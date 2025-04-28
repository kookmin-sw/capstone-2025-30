import cv2
import grpc
import os
import all_predict_sign_pb2
import all_predict_sign_pb2_grpc
import numpy as np
import mediapipe as mp
import json

from dotenv import load_dotenv
import os

load_dotenv()
# 배포용
host = os.getenv("AI_EC2_HOST")
trusted_certs = os.environ['AI_TLS_CRT'].encode('utf-8')
credentials = grpc.ssl_channel_credentials(root_certificates=trusted_certs)

# 배포용
channel = grpc.secure_channel(f"{host}:50051",
                              credentials,
                                  options=[('grpc.max_send_message_length', 10 * 1024 * 1024),
                                           ('grpc.max_receive_message_length', 10 * 1024 * 1024)]) 

# 로컬용
# channel = grpc.insecure_channel(f"localhost:50051",
#                                 options=[('grpc.max_send_message_length', 10 * 1024 * 1024 * 10),  # 100MB
#                                          ('grpc.max_receive_message_length', 10 * 1024 * 1024 * 10)])  # 100MB

stub = all_predict_sign_pb2_grpc.SignAIStub(channel)

# --- 영상 열기 ---
video_path = '화장실 비밀번호 있나요?.mp4'
cap = cv2.VideoCapture(video_path)
if not cap.isOpened():
    print("❌ 비디오를 열 수 없습니다.")
    exit()

fps = cap.get(cv2.CAP_PROP_FPS)
frame_count = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
print(f"비디오 FPS: {fps}")


# --- Mediapipe 초기화 ---
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

# --- 프레임 분석 ---
joint_data_list = []

while True:
    ret, frame = cap.read()
    if not ret:
        break

    img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    result = hands.process(img_rgb)

    if result.multi_hand_landmarks:
        for res in result.multi_hand_landmarks:
            joint = np.zeros((21, 3))
            for j, lm in enumerate(res.landmark):
                joint[j] = [lm.x, lm.y, lm.z]

            joint_data_list.append(joint.flatten())

cap.release()
hands.close()

print(f"📌 추출된 손 좌표 개수: {len(joint_data_list)}")

joints_np = np.array(joint_data_list) 
angles = compute_angles(joints_np)  

flat_joints = angles.flatten().tolist()  

request = all_predict_sign_pb2.FrameSequenceInput(
    frames=flat_joints,
    store_id="store_object_id",
    fps=int(fps),
    video_length=frame_count
)

response = stub.PredictFromFrames(request)
print(f"[결과] Store: {response.store_id}, 문장: {response.predicted_sentence}, Confidence: {response.confidence:.4f}")


# --- For Postman ---
# request_data = {
#     "store_id": "store_object_id",
#     "fps": int(fps),
#     "video_length": frame_count,
#     "frames": flat_joints,
# }

# with open("frame_sequence_input.json", "w", encoding="utf-8") as f:
#     json.dump(request_data, f, ensure_ascii=False, indent=2)

# print("✅ JSON 저장 완료: frame_sequence_input.json")