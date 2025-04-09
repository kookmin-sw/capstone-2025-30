import os
from dotenv import load_dotenv
from pymongo import MongoClient
import gspread
from google.oauth2.service_account import Credentials
from google.auth import default

import mediapipe as mp
import base64
import cv2
import numpy as np

load_dotenv()
mongo_db_url = os.getenv("MONGO_DB_URL")
client = MongoClient(mongo_db_url)
db = client["dev"]
json_key_file = os.getenv("SPREADSHEET_JSON_KEY")

sign_language_collection = db["sign_language"]

name_url_dict = {
    doc["name"]: doc["url"]
    for doc in sign_language_collection.find({}, {"_id": 0, "name": 1, "url": 1})
}

DATA_PATH = "angles"

mp_holistic = mp.solutions.holistic
mp_drawing = mp.solutions.drawing_utils

def process_frame(image_data):
    image_bytes = base64.b64decode(image_data)
    np_arr = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

    return img

def extract_keypoints(results):
    pose = np.array([[res.x, res.y, res.z, res.visibility] for res in
                     results.pose_landmarks.landmark]).flatten() if results.pose_landmarks else np.zeros(33 * 4)
    lh = np.array([[res.x, res.y, res.z] for res in
                   results.left_hand_landmarks.landmark]).flatten() if results.left_hand_landmarks else np.zeros(21 * 3)
    rh = np.array([[res.x, res.y, res.z] for res in
                   results.right_hand_landmarks.landmark]).flatten() if results.right_hand_landmarks else np.zeros(
        21 * 3)
    return np.concatenate([pose, lh, rh])

"""
각도 계산하는 함수
"""
def calculate_angle(a, b, c):
    a = np.array(a)
    b = np.array(b)
    c = np.array(c)

    ba = a - b
    bc = c - b

    cosine_angle = np.dot(ba, bc) / (np.linalg.norm(ba) * np.linalg.norm(bc) + 1e-6)
    angle = np.arccos(np.clip(cosine_angle, -1.0, 1.0))
    return np.degrees(angle)

"""
angle 추출하는 함수
- 팔, 다리, 상체를 계산함
"""

def extract_angles(results):
    if not results.pose_landmarks:
        return np.zeros(6)  # 6개 각도 기본값

    landmarks = results.pose_landmarks.landmark
    get_coord = lambda idx: [landmarks[idx].x, landmarks[idx].y, landmarks[idx].z]

    angles = []

    # 팔
    angles.append(calculate_angle(get_coord(11), get_coord(13), get_coord(15)))  # 왼팔
    angles.append(calculate_angle(get_coord(12), get_coord(14), get_coord(16)))  # 오른팔

    # 다리
    angles.append(calculate_angle(get_coord(23), get_coord(25), get_coord(27)))  # 왼다리
    angles.append(calculate_angle(get_coord(24), get_coord(26), get_coord(28)))  # 오른다리

    # 상체
    angles.append(calculate_angle(get_coord(11), get_coord(23), get_coord(25)))  # 왼상체
    angles.append(calculate_angle(get_coord(12), get_coord(24), get_coord(26)))  # 오른상체

    return np.array(angles)


"""
Mediapipe Hands Model 설정

- 인식할수 있는 손의 갯수 선언 : 양손
- 사용할 손의 유틸리티 선언 : hands 유틸리티
- 회소 탐지 신뢰도, 최소 추적 신뢰도 (기본값 사용) : 0.5
"""
# MAX_NUM_HANDS = 2
# mp_hands=mp.solutions.hands
# mp_drawing = mp.solutions.drawing_utils

"""
Mongo DB에 있는 모든 동영상들 추출
- 처리 중에 성능으로 인한 영상 누락이 발생함 확인 -> 아래 코드에서 대처
"""

"""
두 손의 angles로 학습용 데이터를 사용할 때
"""
# seq_length = 90
# os.makedirs('angles', exist_ok=True)

# for action, url in name_url_dict.items():
#     cap = cv2.VideoCapture(url)
#     if not cap.isOpened():
#         print(f"비디오 열기 오류: {url}")
#         continue

#     fps = cap.get(cv2.CAP_PROP_FPS)
#     total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
#     duration = total_frames / fps if fps > 0 else 0

#     print(f"\n[Action: {action}]")
#     print(f"FPS: {fps}")
#     print(f"총 프레임 수: {total_frames}")
#     print(f"총 재생 시간: {duration:.2f}초")

#     if total_frames < seq_length:
#         print(f"⚠️ 비디오 프레임 수 부족 ({seq_length}프레임 미만): {url}")
#         cap.release()
#         continue

#     start_frame = total_frames - seq_length
#     selected_frames = np.arange(start_frame, total_frames, dtype=int)

#     data = []
#     selected_idx = 0
#     frame_idx = 0

#     with mp_hands.Hands(
#         static_image_mode=False,
#         max_num_hands=2,
#         min_detection_confidence=0.5,
#         min_tracking_confidence=0.5
#     ) as hands:

#         while True:
#             ret, frame = cap.read()
#             if not ret:
#                 break

#             if selected_idx < len(selected_frames) and frame_idx == selected_frames[selected_idx]:
#                 img = cv2.flip(frame, 1)
#                 img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
#                 result = hands.process(img_rgb)

#                 if result.multi_hand_landmarks:
#                     for res in result.multi_hand_landmarks:
#                         joint = np.zeros((21, 3))
#                         for j, lm in enumerate(res.landmark):
#                             joint[j] = [lm.x, lm.y, lm.z]

#                         v1 = joint[[0, 1, 2, 3, 0, 5, 6, 7, 0, 9, 10, 11, 0, 13, 14, 15, 0, 17, 18, 19], :]
#                         v2 = joint[[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], :]
#                         v = v2 - v1
#                         v = v / np.linalg.norm(v, axis=1)[:, np.newaxis]

#                         angle = np.arccos(np.einsum('nt,nt->n',
#                                                     v[[0, 1, 2, 4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18], :],
#                                                     v[[1, 2, 3, 5, 6, 7, 9, 10, 11, 13, 14, 15, 17, 18, 19], :]))
#                         angle = np.degrees(angle)
#                         angle_label = np.array([angle], dtype=np.float32)
#                         angle_label = np.append(angle_label, frame_idx)
#                         d = np.concatenate([joint.flatten(), angle_label])
#                         data.append(d)

#                 selected_idx += 1
#                 if selected_idx >= len(selected_frames):
#                     break

#             frame_idx += 1

#     cap.release()
#     cv2.destroyAllWindows()

#     data = np.array(data)

#     full_seq_data = []
#     for seq in range(len(data) - seq_length + 1):
#         full_seq_data.append(data[seq:seq + seq_length])
#     full_seq_data = np.array(full_seq_data)
#     print(f"[{action}] shape: {full_seq_data.shape}")
#     np.save(os.path.join('angles', f'{action}.npy'), full_seq_data)

    
    # 키포인트로 학습하기 위한 코드
    
    # keypoints_list = []
    # with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
#         frame_idx = 0
#         selected_idx = 0

#         while True:
#             ret, frame = cap.read()
#             if not ret:
#                 break

#             if frame_idx == selected_frames[selected_idx]:
#                 img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#                 results = holistic.process(img_rgb)
#                 angles = extract_angles(results)  # ✅ 여기!
#                 keypoints_list.append(angles)

#                 selected_idx += 1
#                 if selected_idx >= len(selected_frames):
#                     break

#             frame_idx += 1


#     cap.release()

#     # 저장
#     output_dir = os.path.join(DATA_PATH, action)
#     os.makedirs(output_dir, exist_ok=True)

#     for frame_num, keypoint in enumerate(keypoints_list):
#         np.save(os.path.join(output_dir, f"{frame_num}.npy"), keypoint)

#     print(f"[{action}] 모든 키포인트를 저장했습니다!")
#     with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
#         frame_idx = 0
#         selected_idx = 0

#         while True:
#             ret, frame = cap.read()
#             if not ret:
#                 break

#             if frame_idx == selected_frames[selected_idx]:
#                 img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#                 results = holistic.process(img_rgb)
#                 keypoints = extract_keypoints(results)
#                 keypoints_list.append(keypoints)

#                 selected_idx += 1
#                 if selected_idx >= len(selected_frames):
#                     break

#             frame_idx += 1

#     cap.release()

#     # 저장
#     output_dir = os.path.join(DATA_PATH, action)
#     os.makedirs(output_dir, exist_ok=True)

#     for frame_num, keypoint in enumerate(keypoints_list):
#         np.save(os.path.join(output_dir, f"{frame_num}.npy"), keypoint)

#     print(f"[{action}] 모든 키포인트를 저장했습니다!")



""""
누락된 동영상 키포인트 추출
❗누락된 동작이 있습니다:
- 영수증
- 안녕하세요,안녕히 가십시오
- 생크림, 휘핑크림
- 부드럽다
"""
url = "https://drive.google.com/uc?export=download&id=1XVHkBiC7G5eH1ftbXx0vNMsOuxdadfEe"


# # url = "http://sldict.korean.go.kr/multimedia/multimedia_files/convert/20191016/628207/MOV000251499_700X466.mp4"
# action = "생크림, 휘핑크림"
# cap = cv2.VideoCapture(url)
# if not cap.isOpened():
#     print(f"비디오 열기 오류: {url}")
#     cap.release()
#     exit()

# fps = cap.get(cv2.CAP_PROP_FPS)
# total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
# duration = total_frames / fps if fps > 0 else 0

# print(f"\n[Action: {action}]")
# print(f"FPS: {fps}")
# print(f"총 프레임 수: {total_frames}")
# print(f"총 재생 시간: {duration:.2f}초")

# if total_frames < 90:
#     print(f"⚠️ 비디오 프레임 수 부족 (90프레임 미만): {url}")
#     print(f"부족했던 프레임 수 : {total_frames}")
#     cap.release()
#     exit()

# # 마지막 90프레임 선택
# start_frame = total_frames - 90
# selected_frames = np.arange(start_frame, total_frames, dtype=int)

# keypoints_list = []
# with mp.solutions.holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
#     frame_idx = 0
#     selected_idx = 0

#     while True:
#         ret, frame = cap.read()
#         if not ret:
#             break

#         if frame_idx == selected_frames[selected_idx]:
#             img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#             results = holistic.process(img_rgb)
#             keypoints = extract_keypoints(results)
#             keypoints_list.append(keypoints)

#             selected_idx += 1
#             if selected_idx >= len(selected_frames):
#                 break

#         frame_idx += 1

# cap.release()

# with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
#     frame_idx = 0
#     selected_idx = 0

#     while True:
#         ret, frame = cap.read()
#         if not ret:
#             break

#         if frame_idx == selected_frames[selected_idx]:
#             img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#             results = holistic.process(img_rgb)
#             angles = extract_angles(results)  # ✅ 여기!
#             keypoints_list.append(angles)

#             selected_idx += 1
#             if selected_idx >= len(selected_frames):
#                 break

#         frame_idx += 1


# cap.release()

# # 저장
# output_dir = os.path.join(DATA_PATH, action)
# os.makedirs(output_dir, exist_ok=True)

# for frame_num, keypoint in enumerate(keypoints_list):
#     np.save(os.path.join(output_dir, f"{frame_num}.npy"), keypoint)

# print(f"[{action}] 모든 키포인트를 저장했습니다!")


"""
누락된 동작 유무 확인 - 키포인트
"""
# saved_actions = set([
#     f for f in os.listdir(DATA_PATH)
#     if os.path.isdir(os.path.join(DATA_PATH, f))
# ])

# # 2. DB 또는 name_url_dict에 있는 실제 동작 이름
# expected_actions = set(name_url_dict.keys())

# # 3. 누락된 동작 목록
# missing_actions = expected_actions - saved_actions

# # 4. 출력
# if missing_actions:
#     print("❗누락된 동작이 있습니다:")
#     for action in missing_actions:
#         print("-", action)
# else:
#     print("✅ 모든 동작이 저장되어 있습니다!")


"""
누락된 동작 유무 확인 - angle
❗누락된 동작이 있습니다:
- 생크림, 휘핑크림
- 안녕하세요,안녕히 가십시오
"""
# 1. 저장된 액션: angles/ 디렉토리 안의 파일명에서 동작 이름 추출
saved_actions = set([
    filename.replace("seq_", "").replace(".npy", "")
    for filename in os.listdir('angles')
    if filename.endswith(".npy")
])

# 2. 기대되는 액션 목록
expected_actions = set(name_url_dict.keys())

# 3. 누락된 동작
missing_actions = expected_actions - saved_actions

# 4. 출력
if missing_actions:
    print("❗누락된 동작이 있습니다:")
    for action in sorted(missing_actions):
        print("-", action)
else:
    print("✅ 모든 동작이 저장되어 있습니다!")


"""
동작의 갯수 확인
"""
# folders = [f for f in os.listdir(DATA_PATH) if os.path.isdir(os.path.join(DATA_PATH, f))]
# print(f"총 {len(folders)}개의 동작이 저장되어 있습니다.")