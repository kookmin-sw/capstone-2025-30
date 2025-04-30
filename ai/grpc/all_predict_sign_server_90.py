import grpc
from concurrent import futures
import tensorflow as tf
import json
import numpy as np
import mediapipe as mp
import cv2
import os
from tensorflow.keras.layers import Layer
import tensorflow as tf
import all_predict_sign_pb2
import all_predict_sign_pb2_grpc
import load_to_korean_rag
import load_to_sign_rag

# 배포용
# model = tf.keras.models.load_model('models/90_v2_masked_angles.h5')

# 디버깅용
# model = tf.keras.models.load_model('../models/90_v5_masked_angles.h5')

class Attention(Layer):
    def __init__(self, **kwargs): 
        super(Attention, self).__init__(**kwargs)

    def build(self, input_shape):
        self.W = self.add_weight(name="attention_weight", shape=(input_shape[-1], 1),
                                 initializer="normal")
        self.b = self.add_weight(name="attention_bias", shape=(input_shape[1], 1),
                                 initializer="zeros")
        super(Attention, self).build(input_shape)

    def call(self, x):
        e = tf.keras.backend.tanh(tf.keras.backend.dot(x, self.W) + self.b)
        a = tf.keras.backend.softmax(e, axis=1)
        output = x * a
        return tf.keras.backend.sum(output, axis=1)

# 배포용
model = tf.keras.models.load_model(
    'models/90_v6_masked_angles.keras',
    custom_objects={'Attention': Attention}
)

# # 로컬용
# model = tf.keras.models.load_model(
#     '../models/90_v6_masked_angles.keras',
#     custom_objects={'Attention': Attention}
# )

# 배포용
with open('gesture_dict/v6_pad_gesture_dict.json', 'r', encoding='utf-8') as f:

# # 로컬용
# with open('../gesture_dict/v6_pad_gesture_dict.json', 'r', encoding='utf-8') as f:
    gesture_dict = json.load(f)
actions = [gesture_dict[str(i)] for i in range(len(gesture_dict))]

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=True, max_num_hands=2)


class SignAIService(all_predict_sign_pb2_grpc.SignAIServicer):
    def PredictFromFrames(self, request, context):
        joint_data_list = request.frames
        store_id = request.store_id
        fps = request.fps
        video_frames_length = request.video_length
        video_length = video_frames_length / fps

        if len(joint_data_list) < 90 * 78:
            return all_predict_sign_pb2.PredictResult(
                store_id=store_id,
                predicted_sentence="최소 90프레임은 필요합니다!",
                confidence=0.0
            )

        seq_length = 90
        feature_dim = 78
        segment_duration = 3.5
        segment_offset_start = 0.5
        segment_interval = segment_duration + 0.5

        available_time = video_length - segment_offset_start
        num_segments = int(available_time // segment_interval)
        confidence_threshold = 0.97

        full_data = np.array(joint_data_list).reshape(-1, feature_dim)
        total_frames = full_data.shape[0]

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

            start_frame = max(0, min(start_frame, total_frames - seq_length))
            end_frame = min(total_frames, max(end_frame, seq_length))

            segment = full_data[start_frame:end_frame]

            if len(segment) < seq_length:
                print(f"Segment 스킵: {start_time:.2f} - {end_time:.2f} ({len(segment)} < {seq_length})")
                continue

            input_data = segment[:seq_length] 
            pred = model.predict(np.expand_dims(input_data, axis=0))
            pred_label = np.argmax(pred[0])
            predicted_sentence = actions[pred_label]

            if "," in predicted_sentence:
                predicted_sentence = predicted_sentence.split(",")[0]
            confidence = float(pred[0][pred_label])

            if confidence < confidence_threshold:
                alt_sentences = []
                alt_confidences = []

                for offset in [-1, 1]:
                    alt_start_time = start_time + offset / fps
                    alt_start_frame = int(alt_start_time * fps)
                    alt_start_frame = max(0, min(alt_start_frame, total_frames - seq_length))
                    alt_end_frame = alt_start_frame + seq_length

                    if alt_end_frame > total_frames:
                        continue

                    alt_segment = full_data[alt_start_frame:alt_end_frame]
                    alt_pred = model.predict(np.expand_dims(alt_segment, axis=0))
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
                store_id=store_id,
                predicted_sentence="No valid segments",
                confidence=0.0
            )

        final_sentence = ' '.join(sentences)
        final_sentence = load_to_korean_rag.get_translate_from_sign_language(final_sentence)

        print(final_sentence)
        avg_confidence = float(np.mean(confidences))

        return all_predict_sign_pb2.PredictResult(
            store_id=store_id,
            predicted_sentence=final_sentence,
            confidence=avg_confidence
        )



    def TranslateKoreanToSignUrls(self, request, context):
        inqury = request.message
        store_id = request.store_id

        urls = load_to_sign_rag.get_sign_language_url_list(inqury)

        return all_predict_sign_pb2.SignUrlResult(
            store_id=store_id,
            urls=urls
        )

def load_tls_credentials():
    certificate_chain = os.environ['AI_TLS_CRT'].encode('utf-8')
    private_key = os.environ['AI_TLS_KEY'].encode('utf-8')

    return grpc.ssl_server_credentials(
        [(private_key, certificate_chain)],
        root_certificates=None,
        require_client_auth=False
    )

def serve():
    try:
        server = grpc.server(futures.ThreadPoolExecutor(max_workers=10),
                             options=[('grpc.max_send_message_length', 10 * 1024 * 1024),
                                      ('grpc.max_receive_message_length', 10 * 1024 * 1024)])
        all_predict_sign_pb2_grpc.add_SignAIServicer_to_server(SignAIService(), server)
        
        # 배포용
        print("🔐 TLS 인증서 로드 시도 중...")
        creds = load_tls_credentials()
        print("✅ TLS 인증서 로드 성공")
        
        # 배포용
        port_result = server.add_secure_port('[::]:50051', creds)

        # # 로컬용
        # port_result = server.add_insecure_port('[::]:50051')
        
        print(f"✅ 포트 바인딩 결과: {port_result}")
        
        print("🚀 AI 서버 실행 중... 포트: 50051")
        server.start()
        server.wait_for_termination()

    except Exception as e:
        print("❌ 서버 실행 중 에러 발생:", e)

if __name__ == '__main__':
    print("🚀 메인으로 실행됨")
    serve()
