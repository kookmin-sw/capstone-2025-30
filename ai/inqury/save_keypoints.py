import os
from dotenv import load_dotenv
from pymongo import MongoClient

import mediapipe as mp
import cv2
import numpy as np

load_dotenv()
mongo_db_url = os.getenv("MONGO_DB_URL")
json_key_file = os.getenv("SPREADSHEET_JSON_KEY")

client = MongoClient(mongo_db_url)
db = client["dev"]
sign_language_collection = db["sign_language"]


name_url_dict = {
    doc["name"]: doc["url"]
    for doc in sign_language_collection.find({}, {"_id": 0, "name": 1, "url": 1})
}

DATA_PATH = "angles"
mp_hands=mp.solutions.hands

"""
두 손의 angles로 학습용 데이터를 사용할 때
"""
seq_length = 90
os.makedirs('angles', exist_ok=True)

for action, url in name_url_dict.items():
    cap = cv2.VideoCapture(url)
    if not cap.isOpened():
        print(f"비디오 열기 오류: {url}")
        continue

    fps = cap.get(cv2.CAP_PROP_FPS)
    total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    duration = total_frames / fps if fps > 0 else 0

    print(f"\n[Action: {action}]")
    print(f"FPS: {fps}")
    print(f"총 프레임 수: {total_frames}")
    print(f"총 재생 시간: {duration:.2f}초")

    if total_frames < seq_length:
        print(f"⚠️ 비디오 프레임 수 부족 ({seq_length}프레임 미만): {url}")
        cap.release()
        continue

    start_frame = total_frames - seq_length
    selected_frames = np.arange(start_frame, total_frames, dtype=int)

    data = []
    selected_idx = 0
    frame_idx = 0

    with mp_hands.Hands(
    static_image_mode=False,
    max_num_hands=2,
    min_detection_confidence=0.5,
    min_tracking_confidence=0.5
) as hands:

        while True:
            ret, frame = cap.read()
            if not ret:
                break

            if selected_idx < len(selected_frames) and frame_idx == selected_frames[selected_idx]:
                img = cv2.flip(frame, 1)
                img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
                result = hands.process(img_rgb)

                # print(f"프레임 {frame_idx} 검사 중...")

                if result.multi_hand_landmarks:
                    # print(f"➡️ 손 검출됨! 프레임: {frame_idx}")
                    for res in result.multi_hand_landmarks:
                        joint = np.zeros((21, 3))
                        for j, lm in enumerate(res.landmark):
                            joint[j] = [lm.x, lm.y, lm.z]

                        v1 = joint[[0, 1, 2, 3, 0, 5, 6, 7, 0, 9, 10, 11, 0, 13, 14, 15, 0, 17, 18, 19], :]
                        v2 = joint[[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], :]
                        v = v2 - v1
                        v = v / np.linalg.norm(v, axis=1)[:, np.newaxis]

                        angle = np.arccos(np.einsum('nt,nt->n',
                                                    v[[0, 1, 2, 4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18], :],
                                                    v[[1, 2, 3, 5, 6, 7, 9, 10, 11, 13, 14, 15, 17, 18, 19], :]))
                        angle = np.degrees(angle)

                        angle_label = np.array([angle], dtype=np.float32)
                        angle_label = np.append(angle_label, frame_idx)
                        d = np.concatenate([joint.flatten(), angle_label])
                        data.append(d)

                selected_idx += 1
                if selected_idx >= len(selected_frames):
                    break

            frame_idx += 1

    cap.release()
    cv2.destroyAllWindows()

    data = np.array(data)

    # ⚠️ 데이터 수가 부족한 경우, 제로 패딩 추가
    if len(data) < seq_length:
        pad_len = seq_length - len(data)
        pad_data = np.zeros((pad_len, data.shape[1]))
        data = np.vstack([pad_data, data])
        print(f"📌 부족한 {pad_len}개의 프레임을 0으로 패딩 추가했습니다.")

    # 시퀀스 생성
    full_seq_data = []
    for seq in range(len(data) - seq_length + 1):
        full_seq_data.append(data[seq:seq + seq_length])
    full_seq_data = np.array(full_seq_data)

    print(f"[{action}] shape: {full_seq_data.shape}")
    np.save(os.path.join('angles', f"{action}.npy"), full_seq_data)


""""
누락된 동영상 키포인트 추출
❗누락된 동작이 있습니다:
- 안녕하세요,안녕히 가십시오
- 생크림, 휘핑크림
"""
# url = "https://drive.google.com/uc?export=download&id=1XVHkBiC7G5eH1ftbXx0vNMsOuxdadfEe"
# action = "생크림, 휘핑크림"

# seq_length = 90
# url = "https://sldict.korean.go.kr/multimedia/multimedia_files/convert/20191018/628678/MOV000255952_700X466.mp4"
# action = "안녕하세요,안녕히 가십시오"
# cap = cv2.VideoCapture(url)
# if not cap.isOpened():
#     print(f"비디오 열기 오류: {url}")
#     exit()

# fps = cap.get(cv2.CAP_PROP_FPS)
# total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
# duration = total_frames / fps if fps > 0 else 0

# print(f"\n[Action: {action}]")
# print(f"FPS: {fps}")
# print(f"총 프레임 수: {total_frames}")
# print(f"총 재생 시간: {duration:.2f}초")

# if total_frames < seq_length:
#     print(f"⚠️ 비디오 프레임 수 부족 ({seq_length}프레임 미만): {url}")
#     cap.release()
#     exit()

# start_frame = total_frames - seq_length
# selected_frames = np.arange(start_frame, total_frames, dtype=int)

# data = []
# selected_idx = 0
# frame_idx = 0

# with mp_hands.Hands(
#     static_image_mode=False,
#     max_num_hands=2,
#     min_detection_confidence=0.5,
#     min_tracking_confidence=0.5
# ) as hands:

#     while True:
#         ret, frame = cap.read()
#         if not ret:
#             break

#         if selected_idx < len(selected_frames) and frame_idx == selected_frames[selected_idx]:
#             img = cv2.flip(frame, 1)
#             img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
#             result = hands.process(img_rgb)

#             # print(f"프레임 {frame_idx} 검사 중...")

#             if result.multi_hand_landmarks:
#                 # print(f"➡️ 손 검출됨! 프레임: {frame_idx}")
#                 for res in result.multi_hand_landmarks:
#                     joint = np.zeros((21, 3))
#                     for j, lm in enumerate(res.landmark):
#                         joint[j] = [lm.x, lm.y, lm.z]

#                     v1 = joint[[0, 1, 2, 3, 0, 5, 6, 7, 0, 9, 10, 11, 0, 13, 14, 15, 0, 17, 18, 19], :]
#                     v2 = joint[[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], :]
#                     v = v2 - v1
#                     v = v / np.linalg.norm(v, axis=1)[:, np.newaxis]

#                     angle = np.arccos(np.einsum('nt,nt->n',
#                                                 v[[0, 1, 2, 4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18], :],
#                                                 v[[1, 2, 3, 5, 6, 7, 9, 10, 11, 13, 14, 15, 17, 18, 19], :]))
#                     angle = np.degrees(angle)

#                     angle_label = np.array([angle], dtype=np.float32)
#                     angle_label = np.append(angle_label, frame_idx)
#                     d = np.concatenate([joint.flatten(), angle_label])
#                     data.append(d)

#             selected_idx += 1
#             if selected_idx >= len(selected_frames):
#                 break

#         frame_idx += 1

# cap.release()
# cv2.destroyAllWindows()

# data = np.array(data)

# # ⚠️ 데이터 수가 부족한 경우, 제로 패딩 추가
# if len(data) < seq_length:
#     pad_len = seq_length - len(data)
#     pad_data = np.zeros((pad_len, data.shape[1]))
#     data = np.vstack([pad_data, data])
#     print(f"📌 부족한 {pad_len}개의 프레임을 0으로 패딩 추가했습니다.")

# # 시퀀스 생성
# full_seq_data = []
# for seq in range(len(data) - seq_length + 1):
#     full_seq_data.append(data[seq:seq + seq_length])
# full_seq_data = np.array(full_seq_data)

# print(f"[{action}] shape: {full_seq_data.shape}")
# np.save(os.path.join('angles', f"{action}.npy"), full_seq_data)


"""
누락된 동작 유무 확인 - angle
❗누락된 동작이 있습니다:
- 생크림, 휘핑크림
- 안녕하세요,안녕히 가십시오
"""
# saved_actions = set([
#     os.path.splitext(f)[0] for f in os.listdir(DATA_PATH)
#     if f.endswith('.npy')
# ])

# expected_actions = set(name_url_dict.keys())

# missing_actions = expected_actions - saved_actions

# if missing_actions:
#     print("❗누락된 동작이 있습니다:")
#     for action in sorted(missing_actions):
#         print("-", action)
# else:
#     print("✅ 모든 동작이 저장되어 있습니다!")



"""
동작의 갯수 확인
"""
# npy_files = [f for f in os.listdir(DATA_PATH) if f.endswith('.npy')]
# print(f"총 {len(npy_files)}개의 npy 파일이 저장되어 있습니다.")