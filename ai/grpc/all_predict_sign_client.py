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
host = os.getenv("AI_EC2_HOST")
env = os.getenv('APP_ENV', 'local')
trusted_certs = os.environ['AI_TLS_CRT'].encode('utf-8')
credentials = grpc.ssl_channel_credentials(root_certificates=trusted_certs)

if env == 'production':
    channel = grpc.secure_channel(f"{host}:50051",
                                credentials,
                                    options=[('grpc.max_send_message_length', 10 * 1024 * 1024),
                                            ('grpc.max_receive_message_length', 10 * 1024 * 1024)]) 
else :
    channel = grpc.insecure_channel(f"localhost:50051",
                                    options=[('grpc.max_send_message_length', 10 * 1024 * 1024), 
                                             ('grpc.max_receive_message_length', 10 * 1024 * 1024)])

stub = all_predict_sign_pb2_grpc.SignAIStub(channel)

# --- 영상 열기 ---

"""
잘 맞춤
- 포크와 휴지의 경우 단어 단일로 예측될 경우 자동으로 "가 있나요"를 붙이게 하드코딩함
"""
# video_path = '키오스크 주문이 어려운데 도와주세요.mp4'
# video_path = '영수증 주세요.mp4'
# video_path = '따뜻하게 해주세요.mp4'
# video_path = '화장실 비밀번호 있나요?.mp4'
# video_path = '휴지 있어요_.mp4'
# video_path = '포크가 있어요_.mp4'
# video_path = '아메리카노_수어통합본.mp4'
# video_path = '긍정.mp4'


# video_path = '기2.mp4'
# video_path = '화2.mp4'
# video_path = "화_1초추가_8.mp4"
# video_path = "영_1초추가.mp4"
# video_path = "긍1.mp4"
# video_path = "교_1초추가_2.mp4"
# video_path = '따_1초추가_6.mp4'
# video_path = "자_1초추가.mp4"
video_path = ""


"""
약간의 손실 - 의미 유추 가능
"""
# video_path = "차_1초추가_2.mp4"
# video_path = '기_1초추가.mp4'

"""
치명적 손실 - 의미 유추 애매
v9 
- 카드를 사용하여 키오스크에서 결제하다
- 지폐를 포장해 주세요
"""
# video_path = '할인카드 사용하고 싶어요.mp4'
# video_path = '현금결제 원해요.mp4'
# video_path = '현1.mp4'
# video_path = "할_1초추가.mp4"

"""
한 단어만 맞춤 - 의미 유추 불가능
"""
# video_path = "http://sldict.korean.go.kr/multimedia/multimedia_files/convert/20200825/735712/MOV000240883_700X466.mp4"
# video_path = '포인트가 있나요?.mp4'
# video_path = "덜 달게 해주세요.mp4"
# video_path = "덜2.mp4"
# video_path = "포_1초추가.mp4"

"""
전혀 안됨 - 의미 유추 불가능
"""
# video_path = "돈1.mp4"
# video_path = '환1.mp4'

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


# # --- For Postman ---
# request_data = {
#     "store_id": "store_object_id",
#     "fps": int(fps),
#     "video_length": frame_count,
#     "frames": flat_joints,
# }

# with open("차2.json", "w", encoding="utf-8") as f:
#     json.dump(request_data, f, ensure_ascii=False, indent=2)

# print("✅ JSON 저장 완료: frame_sequence_input.json")