import cv2
import numpy as np
import grpc
import time
import mediapipe as mp

import predict_sign_pb2
import predict_sign_pb2_grpc

channel = grpc.insecure_channel('localhost:50051')
stub = predict_sign_pb2_grpc.SignAIStub(channel)

video_path = '아메리카노_수어통합본.mp4'
cap = cv2.VideoCapture(video_path)

if not cap.isOpened():
    print("비디오를 열 수 없습니다.")
    exit()

fps = cap.get(cv2.CAP_PROP_FPS)
start_frame = int(fps * 0.5)
seq_length = 90

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=True, max_num_hands=2)

sequence = []
frame_idx = 0
while len(sequence) < 90:
    ret, frame = cap.read()
    if not ret:
        break
    if frame_idx < start_frame:
        frame_idx += 1
        continue

    img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    result = hands.process(img_rgb)

    if result.multi_hand_landmarks:
        for res in result.multi_hand_landmarks:
            joint = np.zeros((21, 3))
            for j, lm in enumerate(res.landmark):
                joint[j] = [lm.x, lm.y, lm.z]

            d = joint.flatten()
            sequence.append(d)

    frame_idx += 1


cap.release()
hands.close()

if len(sequence) < seq_length:
    print("⚠️ 검출된 손 시퀀스가 부족합니다. 총:", len(sequence))
    exit()

sequence = np.array(sequence[:seq_length]).flatten().tolist()

request = predict_sign_pb2.SequenceInput(
    values=sequence,
    client_id="client_01"
)


response = stub.Predict(request)
# [예측 결과] Client: client_01, 단어: 커피
print(f"[예측 결과] Client: {response.client_id}, 단어: {response.predicted_word}")
