import grpc
from concurrent import futures
import numpy as np
import json
import tensorflow as tf

import predict_sign_pb2
import predict_sign_pb2_grpc

model = tf.keras.models.load_model('../90_pad_hands_angles.h5')
with open('../pad_gesture_dict.json', 'r', encoding='utf-8') as f:
    gesture_dict = json.load(f)
actions = [gesture_dict[str(i)] for i in range(len(gesture_dict))]

def compute_angles(joints_63):
    joints = joints_63.reshape(90, 21, 3)
    seq_out = []

    for joint in joints:
        v1 = joint[[0,1,2,3,0,5,6,7,0,9,10,11,0,13,14,15,0,17,18,19]]
        v2 = joint[[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]]
        v = v2 - v1
        v = v / np.linalg.norm(v, axis=1)[:, np.newaxis]

        angle = np.arccos(np.einsum('nt,nt->n',
            v[[0,1,2,4,5,6,8,9,10,12,13,14,16,17,18]],
            v[[1,2,3,5,6,7,9,10,11,13,14,15,17,18,19]]
        ))
        angle = np.degrees(angle)

        feature = np.concatenate([joint.flatten(), angle])
        seq_out.append(feature)

    return np.array(seq_out)


class SignAIService(predict_sign_pb2_grpc.SignAIServicer):
    def Predict(self, request, context):
        values = np.array(request.values).reshape(90, 63)
        seq = compute_angles(values)

        pred = model.predict(np.expand_dims(seq, axis=0))
        pred_label = np.argmax(pred[0])
        predicted_word = actions[pred_label]

        return predict_sign_pb2.PredictResult(
            client_id=request.client_id,
            predicted_word=predicted_word
        )



def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=4))
    predict_sign_pb2_grpc.add_SignAIServicer_to_server(SignAIService(), server)
    server.add_insecure_port('[::]:50051')
    print("🚀 AI 서버 실행 중... 포트: 50051")
    server.start()
    server.wait_for_termination()


if __name__ == '__main__':
    serve()
