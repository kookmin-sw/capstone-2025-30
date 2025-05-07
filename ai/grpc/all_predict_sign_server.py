import grpc
from concurrent import futures
import tensorflow as tf
import json
import numpy as np
import mediapipe as mp
import os
from tensorflow.keras.layers import Layer
import tensorflow as tf
import all_predict_sign_pb2
import all_predict_sign_pb2_grpc
import load_to_korean_rag
import load_to_sign_rag

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

env = os.getenv('APP_ENV', 'local')

if env == "production":
    model = tf.keras.models.load_model(
        'models/60_v8_masked_angles.keras',
        custom_objects={'Attention': Attention}
    )
else:
    model = tf.keras.models.load_model(
    '../models/60_v8_masked_angles.keras',
    custom_objects={
        'Attention': Attention,
        # 'loss': focal_loss(gamma=2., alpha=0.25)
    }
    )


def focal_loss(gamma=2.0, alpha=0.25):
    def loss(y_true, y_pred):
        y_pred = tf.clip_by_value(y_pred, 1e-9, 1.0)  # log(0) 방지
        cross_entropy = -y_true * tf.math.log(y_pred)
        weight = alpha * tf.pow(1 - y_pred, gamma)
        return tf.reduce_mean(tf.reduce_sum(weight * cross_entropy, axis=-1))
    return loss

if env == 'production':
    path = 'gesture_dict/60_v8_pad_gesture_dict.json'
else:
    path = '../gesture_dict/60_v8_pad_gesture_dict.json'

with open(path, 'r', encoding='utf-8') as f:
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

        if len(joint_data_list) < 60 * 78:
            return all_predict_sign_pb2.PredictResult(
                store_id=store_id,
                predicted_sentence="최소 60프레임은 필요합니다!",
                confidence=0.0
            )
        
        confidence_threshold = 0.97
        motion_threshold = 0.02
        seq_length = 60
        feature_dim = 78

        full_data = np.array(joint_data_list).reshape(-1, feature_dim)
        total_frames = full_data.shape[0]

        sentences = []
        confidences = []

        sentences = []
        confidences = []

        motion_start_frames = []
        prev_frame = None

        for idx in range(total_frames):
            current_frame = full_data[idx]
            if prev_frame is not None:
                diff = np.linalg.norm(current_frame - prev_frame)
                if diff > motion_threshold:
                    motion_start_frames.append(idx)
            prev_frame = current_frame

        # 중복 제거 (간격 좁은 건 스킵)
        filtered_start_frames = []
        min_gap = int(fps * 2.5)  # 최소 2.5초 간격
        last_added = -min_gap

        for f in motion_start_frames:
            if f - last_added >= min_gap:
                filtered_start_frames.append(f)
                last_added = f

        # 추출된 시점부터 시퀀스 예측
        for start_frame in filtered_start_frames:

            end_frame = start_frame + seq_length
            if end_frame > total_frames:
                continue

            segment = full_data[start_frame:end_frame]
            input_data = segment[:seq_length]

            pred = model.predict(np.expand_dims(input_data, axis=0))
            pred_label = np.argmax(pred[0])
            predicted_sentence = actions[pred_label]
            confidence = float(pred[0][pred_label])

            if "," in predicted_sentence:
                predicted_sentence = predicted_sentence.split(",")[0]

            if start_frame == 1 and predicted_sentence == "마시다":
                continue

            if confidence < confidence_threshold:
                continue 
            
            if predicted_sentence == "기계":
                predicted_sentence = "키오스크"
                
            sentences.append(predicted_sentence)
            confidences.append(confidence)
            print(f"Motion Segment @ Frame {start_frame}: Sentence: {predicted_sentence}, Confidence: {confidence:.4f}")
            
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
        
        if env == "production":
            creds = load_tls_credentials()
            print("✅ TLS 인증서 로드 성공")
            port_result = server.add_secure_port('[::]:50051', creds)
        else:
            port_result = server.add_insecure_port('[::]:50051')
        
        print(f"✅ 포트 바인딩 결과: {port_result}")
        
        print("🚀 AI 서버 실행 중... 포트: 50051")
        server.start()
        server.wait_for_termination()

    except Exception as e:
        print("❌ 서버 실행 중 에러 발생:", e)

if __name__ == '__main__':
    print("🚀 메인으로 실행됨")
    serve()
