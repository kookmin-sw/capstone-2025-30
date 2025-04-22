import grpc
from concurrent import futures
import tensorflow as tf
import json
import numpy as np
import mediapipe as mp
import cv2
import all_predict_sign_pb2
import all_predict_sign_pb2_grpc
import load_to_korean_rag
import load_to_sign_rag

model = tf.keras.models.load_model('models/90_masked_angles.h5')

with open('gesture_dict/pad_gesture_dict.json', 'r', encoding='utf-8') as f:
    gesture_dict = json.load(f)
actions = [gesture_dict[str(i)] for i in range(len(gesture_dict))]

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=True, max_num_hands=2)

def compute_angles(joints_63):
    joints = joints_63.reshape(-1, 21, 3)
    seq_out = []

    for joint in joints:
        v1 = joint[[0,1,2,3,0,5,6,7,0,9,10,11,0,13,14,15,0,17,18,19], :]
        v2 = joint[[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20], :]
        v = v2 - v1
        v = v / np.linalg.norm(v, axis=1)[:, np.newaxis]

        angle = np.arccos(np.einsum('nt,nt->n',
            v[[0,1,2,4,5,6,8,9,10,12,13,14,16,17,18],:], 
            v[[1,2,3,5,6,7,9,10,11,13,14,15,17,18,19],:]
        ))
        angle = np.degrees(angle)

        feature = np.concatenate([joint.flatten(), angle])
        seq_out.append(feature)

    return np.array(seq_out)

class SignAIService(all_predict_sign_pb2_grpc.SignAIServicer):
    def PredictFromFrames(self, request, context):
        frames = request.frames
        client_id = request.client_id
        fps = request.fps
        video_length = request.video_length

        joint_data_list = []
        for frame_bytes in frames:
            np_arr = np.frombuffer(frame_bytes, np.uint8)
            frame = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
            img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

            result = hands.process(img_rgb)
            if result.multi_hand_landmarks:
                for res in result.multi_hand_landmarks:
                    joint = np.zeros((21, 3))
                    for j, lm in enumerate(res.landmark):
                        joint[j] = [lm.x, lm.y, lm.z]

                    joint_data_list.append(joint.flatten())

        if len(joint_data_list) < 90:
            return all_predict_sign_pb2.PredictResult(
                client_id=client_id,
                predicted_sentence=" ",
                confidence=0.0
            )

        seq_length = 90 
        num_segments = 7 
        segment_duration = 3.5 
        segment_offset_start = 0.5 
        confidence_threshold = 0.97

        sentences = []
        confidences = []

        for i in range(num_segments):
            start_time = segment_offset_start + i * (segment_duration + 0.5) 
            end_time = start_time + segment_duration

            
            if end_time > video_length:
                end_time = video_length
                if start_time > video_length:
                    break  

            start_frame = int(start_time * fps)
            end_frame = int(end_time * fps)

            start_frame = max(0, min(start_frame, len(joint_data_list) - seq_length))
            end_frame = min(len(joint_data_list), max(end_frame, seq_length))

            segment = joint_data_list[start_frame:end_frame]

            if len(segment) < seq_length:
                print(f"Segment 스킵: {start_time:.2f} - {end_time:.2f} ({len(segment)} < {seq_length})")
                continue

            joints_np = np.array(segment).reshape(-1, 63)
            angles = compute_angles(joints_np)

            pred = model.predict(np.expand_dims(angles, axis=0))
            pred_label = np.argmax(pred[0])
            predicted_sentence = actions[pred_label]

            if "," in predicted_sentence:
                predicted_sentence = predicted_sentence.split(",")[0]
            confidence = float(pred[0][pred_label])


            if confidence < confidence_threshold:
                alt_sentences = []
                alt_confidences = []
                alt_frames = [-1, 1] 

                for frame_offset in alt_frames:
                    alt_start_time = start_time + frame_offset / fps  
                    alt_start_frame = int(alt_start_time * fps)

                    alt_start_frame = max(0, min(alt_start_frame, len(joint_data_list) - seq_length))
                    alt_end_frame = min(len(joint_data_list), max(alt_start_frame + seq_length, seq_length))

                    if alt_end_frame - alt_start_frame < seq_length:
                        print(f"Alternative Segment 스킵: {alt_start_time:.2f} ({alt_end_frame - alt_start_frame} < {seq_length})")
                        continue

                    alt_segment = joint_data_list[alt_start_frame:alt_end_frame]
                    alt_joints_np = np.array(alt_segment).reshape(-1, 63)
                    alt_angles = compute_angles(alt_joints_np)

                    alt_pred = model.predict(np.expand_dims(alt_angles, axis=0))
                    alt_pred_label = np.argmax(alt_pred[0])
                    alt_predicted_sentence = actions[alt_pred_label]
                    alt_confidence = float(alt_pred[0][alt_pred_label])

                    alt_sentences.append(alt_predicted_sentence)
                    alt_confidences.append(alt_confidence)

                    print(f"Alternative Segment: {alt_start_time:.2f}, Sentence: {alt_predicted_sentence}, Confidence: {alt_confidence:.4f}")

                if alt_confidences:
                    best_index = np.argmax(alt_confidences)
                    if alt_confidences[best_index] > 0.88:
                        predicted_sentence = alt_sentences[best_index]
                        confidence = alt_confidences[best_index]
                        print(f"대체 Segment 선택: Sentence: {predicted_sentence}, Confidence: {confidence:.4f}")
                    else:
                        continue
            sentences.append(predicted_sentence)
            confidences.append(confidence)

            print(f"Segment {i+1}: {start_time:.2f} - {end_time:.2f}, Sentence: {predicted_sentence}, Confidence: {confidence:.4f}")

        if not sentences:
            return all_predict_sign_pb2.PredictResult(
                client_id=client_id,
                predicted_sentence="No valid segments",
                confidence=0.0
            )

        final_sentence = ' '.join(sentences)
        final_sentence = load_to_korean_rag.get_translate_from_sign_language(final_sentence)

        print(final_sentence)
        avg_confidence = float(np.mean(confidences))

        return all_predict_sign_pb2.PredictResult(
            client_id=client_id,
            predicted_sentence=final_sentence,
            confidence=avg_confidence
        )

    def TranslateKoreanToSignUrls(self, request, context):
        inqury = request.message
        client_id = request.client_id

        urls = load_to_sign_rag.get_sign_language_url_list(inqury)

        return all_predict_sign_pb2.SignUrlResult(
            client_id=client_id,
            urls=urls
        )

def load_tls_credentials():
    with open('certs/server.crt', 'rb') as f:
        certificate_chain = f.read()
    with open('certs/server.key', 'rb') as f:
        private_key = f.read()

    return grpc.ssl_server_credentials(
        [(private_key, certificate_chain)],
        root_certificates=None,
        require_client_auth=False
    )

def serve():
    try:
        server = grpc.server(futures.ThreadPoolExecutor(max_workers=10),
                             options=[('grpc.max_send_message_length', 10 * 1024 * 1024 * 10),
                                      ('grpc.max_receive_message_length', 10 * 1024 * 1024 * 10)])
        all_predict_sign_pb2_grpc.add_SignAIServicer_to_server(SignAIService(), server)
        
        print("🔐 TLS 인증서 로드 시도 중...")
        creds = load_tls_credentials()
        print("✅ TLS 인증서 로드 성공")
        
        port_result = server.add_secure_port('[::]:50051', creds)
        print(f"✅ 포트 바인딩 결과: {port_result}")
        
        print("🚀 AI 서버 실행 중... 포트: 50051")
        server.start()
        server.wait_for_termination()
    except Exception as e:
        print("❌ 서버 실행 중 에러 발생:", e)

if __name__ == '__main__':
    print("🚀 메인으로 실행됨")
    serve()
