import os
import cv2
import numpy as np
import pandas as pd
import mediapipe as mp
from tensorflow.keras.utils import to_categorical
from sklearn.model_selection import train_test_split
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Flatten, Conv1D, MaxPooling1D
from tensorflow.keras.callbacks import ReduceLROnPlateau
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.callbacks import EarlyStopping
from PIL import ImageFont
import base64

raw_data = pd.read_csv("dataset.csv")
DATA_PATH = os.path.join('holistic_dataset')
# gesture = {i: title for i, title in enumerate(raw_data["Title"])}

# 훈련을 위한 데이터 셋의 라벨링 작업
urls = raw_data['SubDescription'][:10]
actions = raw_data["Title"][:10].tolist()
actions = np.array(actions)

# 라벨 매핑
# 테스트의 경우 : {'느끼다,느낌,뉘앙스': 0, '장애인 기능 경진 대회': 1, '똑같다,같다,동일하다': 2, '가난,곤궁,궁핍,빈곤': 3, '반복,거듭,수시로,자꾸,자주,잦다,여러 번,연거푸': 4, '가치': 5, '의사소통': 6, '걷어차다': 7, '문화재': 8, '방심,부주의': 9} 
label_map = {label: num for num, label in enumerate(actions)}
# print(label_map)

# 영상 학습 반복 횟수, 프레임 기준 
no_sequences = 30
sequence_length = 30

# mediapipe holistic 범위 이용 & 그리기 모듈
mp_holistic = mp.solutions.holistic
mp_drawing = mp.solutions.drawing_utils

# 한글 폰트 설정
font_path = "/Library/Fonts/AppleGothic.ttf"
font = ImageFont.truetype(font_path, 32)

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
1-1. 비디오 키포인트 담을 디렉터리 구조 세팅 및 키포인트 저장
shape : (258,) - 1차원 형태
"""
# for i, action in enumerate(actions):
#     cap = cv2.VideoCapture(urls[i])  # 비디오 로드
#     if not cap.isOpened():
#         print(f"비디오 열기 오류: {urls[i]}")
#         continue

#     for sequence in range(no_sequences):  # 각 동작별 30개의 시퀀스 생성
#         keypoints_list = []  # 한 시퀀스의 keypoints 저장용 리스트

#         with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
#             frame_idx = 0
#             while frame_idx < sequence_length:  # 무조건 30개의 프레임 확보
#                 ret, frame = cap.read()

#                 if not ret:  # 비디오가 끝났을 경우
#                     keypoints = np.zeros(258)  # 빈 프레임을 0으로 채움
#                 else:
#                     img_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#                     results = holistic.process(img_rgb)
#                     keypoints = extract_keypoints(results)

#                 keypoints_list.append(keypoints)
#                 frame_idx += 1  # 30 프레임 채울 때까지 반복

#         # 데이터 저장 (sequence 단위로 저장)
#         output_dir = os.path.join(DATA_PATH, action, str(sequence))
#         os.makedirs(output_dir, exist_ok=True)

#         for frame_num, keypoint in enumerate(keypoints_list):
#             np.save(os.path.join(output_dir, f"{frame_num}.npy"), keypoint)

#     cap.release()

"""
1-2. 데이터 로드 테스트
올바른 형태는 아래와 같음
✅ 데이터 로드 성공
데이터 타입: <class 'numpy.ndarray'>
데이터 shape: (258,)
"""
# keypoint = np.load("holistic_dataset/걷어차다/0/0.npy")
# print(keypoint.shape)  # (258,)

# sequence = 0  # 확인할 시퀀스 번호
# frame_num = 0  # 확인할 프레임 번호
# action = "느끼다,느낌,뉘앙스"

# # `.npy` 파일 경로
# file_path = os.path.join(DATA_PATH, action, str(sequence), f"{frame_num}.npy")

# # 파일이 존재하는지 확인
# if os.path.exists(file_path):
#     keypoints = np.load(file_path)
    
#     print("✅ 데이터 로드 성공")
#     print(f"데이터 타입: {type(keypoints)}")
#     print(f"데이터 shape: {keypoints.shape}")
#     print(f"데이터 예시 (앞부분): \n{keypoints[:5]}")  # 일부 데이터 출력
# else:
#     print("❌ 파일이 존재하지 않습니다.")

"""
2. 데이터 로드 및 모델 학습
- 3차 고도화 -> 데이터 증강 적용
"""
sequences, labels = [], []
for action in actions:
    for sequence in range(no_sequences):
        window = []
        for frame_num in range(sequence_length):  # seqeunce_length = 30
            res = np.load(os.path.join(DATA_PATH, action, str(sequence), "{}.npy".format(frame_num)))
            window.append(res)
        sequences.append(window)
        labels.append(label_map[action])

# print(np.array(sequences).shape)

# 랜덤 시드 설정
np.random.seed(42)
tf.random.set_seed(42)

# 데이터 증강 함수 정의
def augment_data(X):
    X_aug = []
    for x in X:
        # 시간축 이동 (Shift)
        shift = np.random.randint(-3, 3)  # -3~+3 프레임 이동
        x_shifted = np.roll(x, shift, axis=0)
        
        # 랜덤 잡음 추가 (Gaussian Noise)
        noise = np.random.normal(0, 0.02, x.shape)  # 평균 0, 표준편차 0.02
        x_noisy = x_shifted + noise
        
        # 크기 변환 (Time Stretch)
        scale_factor = np.random.uniform(0.9, 1.1)  # 0.9배 ~ 1.1배 조정
        x_scaled = x_noisy * scale_factor
        
        X_aug.append(x_scaled)
    
    return np.array(X_aug)

X = np.array(sequences)
y = to_categorical(labels).astype(int)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)
# 데이터 증강 적용
X_train_aug = augment_data(X_train)

# 데이터 정규화
X_train_aug = X_train_aug / np.max(X_train_aug)
X_test = X_test / np.max(X_test)

# EarlyStopping & ReduceLROnPlateau 설정
early_stopping = EarlyStopping(monitor='loss', patience=20, min_delta=0.0005, verbose=1, restore_best_weights=True)
reduce_lr = ReduceLROnPlateau(monitor='loss', factor=0.5, patience=5, min_lr=1e-4, verbose=1)

# 모델 생성
model = Sequential([
    Conv1D(64, 3, activation='relu', input_shape=(30, 258)),
    MaxPooling1D(2),
    Conv1D(128, 3, activation='relu'),
    MaxPooling1D(2),
    Conv1D(64, 3, activation='relu'),
    MaxPooling1D(2),
    Flatten(),
    Dense(64, activation='relu'),
    Dense(32, activation='relu'),
    Dense(y.shape[1], activation='softmax')  # 'actions.shape[0]' 대신 'y.shape[1]' 사용
])

# 모델 컴파일
model.compile(
    optimizer=Adam(learning_rate=0.0005),
    loss='categorical_crossentropy',
    metrics=['categorical_accuracy']
)

# 모델 학습
model.fit(X_train_aug, y_train, batch_size=32, epochs=2000, callbacks=[early_stopping, reduce_lr])

# 모델 저장
model.save('handTalker_v1_augmented.keras')
