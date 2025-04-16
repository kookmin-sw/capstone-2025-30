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
import json
import matplotlib.pyplot as plt


from sklearn.model_selection import train_test_split
from sklearn.utils.class_weight import compute_class_weight

import tensorflow as tf
from tensorflow.keras.layers import Masking, LSTM, Dense, Flatten, Conv1D, MaxPooling1D, TimeDistributed, Reshape, Input, Dropout
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.callbacks import EarlyStopping

from tensorflow.keras.models import Sequential
from tensorflow.keras.callbacks import ModelCheckpoint, ReduceLROnPlateau

import random

load_dotenv()
mongo_db_url = os.getenv("MONGO_DB_URL")
client = MongoClient(mongo_db_url)
db = client["dev"]

sign_language_collection = db["sign_language"]
name_url_dict = {
    doc["name"]: doc["url"]
    for doc in sign_language_collection.find({}, {"_id": 0, "name": 1, "url": 1})
}


DATA_PATH = "angles_after_pad"
data_list = []
gesture = {}
label_index = 0

for action in name_url_dict.keys():
    file_path = os.path.join(DATA_PATH, f"{action}.npy")
    if not os.path.exists(file_path):
        print(f"⚠️ 데이터 누락: {action} - {file_path} 없음")
        continue

    seq_data = np.load(file_path)
    if seq_data.ndim != 3 or seq_data.shape[0] == 0:
        print(f"⚠️ 유효하지 않은 시퀀스: {action} - shape: {seq_data.shape}")
        continue

    seq_data[:, :, -1] = label_index
    gesture[label_index] = action  
    label_index += 1

    data_list.append(seq_data)

if not data_list:
    raise ValueError("불러온 데이터가 없습니다. 모델 학습 불가")

data = np.concatenate(data_list, axis=0)
x_data = data[:, :, :-1]
labels = data[:, 0, -1].astype(int)
y_data = to_categorical(labels, num_classes=len(gesture))

x_train, x_val, y_train, y_val = train_test_split(
    x_data, y_data, test_size=0.1, random_state=2021
)

def augment_sequence(seq, jitter_prob=0.3, noise_std=0.01, angle_perturb_range=2.0):
    augmented = seq.copy()

    # 1. ⏱️ Temporal jitter: 순서를 약간 섞음
    if random.random() < jitter_prob:
        idx = np.arange(len(augmented))
        jitter = np.clip(np.random.normal(0, 1, size=len(idx)), -2, 2).astype(int)
        jittered_idx = np.clip(idx + jitter, 0, len(idx) - 1)
        augmented = augmented[jittered_idx]

    # 2. 🌫️ Joint 좌표에 noise 추가
    joint_dim = 21 * 3  # 63
    augmented[:, :joint_dim] += np.random.normal(0, noise_std, size=(augmented.shape[0], joint_dim))

    # 3. 🔄 각도 값에 ±1~2도 perturbation
    angle_dim = 15
    angle_start = joint_dim
    angle_end = joint_dim + angle_dim
    perturb = np.random.uniform(-angle_perturb_range, angle_perturb_range, size=(augmented.shape[0], angle_dim))
    augmented[:, angle_start:angle_end] += perturb

    return augmented

augmented_train = []
augmented_labels = []

for i in range(len(x_train)):
    augmented_train.append(x_train[i])
    augmented_labels.append(y_train[i])

    # 증강 샘플 추가 (예: 1개씩 증강 → 2배 데이터)
    augmented_train.append(augment_sequence(x_train[i]))
    augmented_labels.append(y_train[i])

x_train = np.array(augmented_train)
y_train = np.array(augmented_labels)

print(f"📦 증강된 학습 데이터: {x_train.shape}, 라벨: {y_train.shape}")

model = Sequential([
    Input(shape=x_train.shape[1:]),              
    Masking(mask_value=0.0),                     
    LSTM(128, return_sequences=True),
    LSTM(64),
    Dense(64, activation='relu'),
    Dropout(0.5),
    Dense(len(gesture), activation='softmax')
])

model.compile(
    optimizer='adam',
    loss='categorical_crossentropy',
    metrics=['acc']
)

model.summary()

weights = compute_class_weight('balanced', classes=np.unique(labels), y=labels)
class_weights = dict(enumerate(weights))

history = model.fit(
    x_train, y_train,
    validation_data=(x_val, y_val),
    epochs=200,
    callbacks=[
        ModelCheckpoint('90_aug_masked_angles.h5', monitor='val_acc', verbose=1, save_best_only=True, mode='auto'),
        ReduceLROnPlateau(monitor='val_acc', factor=0.5, patience=50, verbose=1, mode='auto')
    ],
    class_weight=class_weights
)



fig, loss_ax = plt.subplots(figsize=(16, 10))
acc_ax = loss_ax.twinx()

loss_ax.plot(history.history['loss'], 'y', label='train loss')
loss_ax.plot(history.history['val_loss'], 'r', label='val loss')
loss_ax.set_xlabel('epoch')
loss_ax.set_ylabel('loss')
loss_ax.legend(loc='upper left')

acc_ax.plot(history.history['acc'], 'b', label='train acc')
acc_ax.plot(history.history['val_acc'], 'g', label='val acc')
acc_ax.set_ylabel('accuracy')
acc_ax.legend(loc='upper left')

plt.title('Model Training History')
plt.grid(True)
plt.show()


model.save('90_aug_masked_angles.h5')
print("✅ 모델 저장 완료: 90_aug_masked_angles.h5")


with open('pad_gesture_dict.json', 'w', encoding='utf-8') as f:
    json.dump(gesture, f, ensure_ascii=False, indent=2)
print("✅ 제스처 라벨 딕셔너리 저장 완료: pad_gesture_dict.json")


"""
Holistic Version
"""

# DATA_PATH = "angles"

# mp_holistic = mp.solutions.holistic
# mp_drawing = mp.solutions.drawing_utils


# def process_frame(image_data):
#     image_bytes = base64.b64decode(image_data)
#     np_arr = np.frombuffer(image_bytes, np.uint8)
#     img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

#     return img

# def extract_keypoints(results):
#     pose = np.array([[res.x, res.y, res.z, res.visibility] for res in
#                      results.pose_landmarks.landmark]).flatten() if results.pose_landmarks else np.zeros(33 * 4)
#     lh = np.array([[res.x, res.y, res.z] for res in
#                    results.left_hand_landmarks.landmark]).flatten() if results.left_hand_landmarks else np.zeros(21 * 3)
#     rh = np.array([[res.x, res.y, res.z] for res in
#                    results.right_hand_landmarks.landmark]).flatten() if results.right_hand_landmarks else np.zeros(
#         21 * 3)
#     return np.concatenate([pose, lh, rh])

# valid_actions = []
# sequences, labels = [], []

# actions = list(name_url_dict.keys())
# label_map = {name: i for i, name in enumerate(actions)}

# NUM_FRAMES = 90
# NUM_ANGLES = 6  # 각 프레임당 각도 수

# for action in actions:
#     action_path = os.path.join(DATA_PATH, action)
    
#     if not os.path.exists(action_path):
#         print(f"❌ Skipping missing action directory: {action}")
#         continue

#     keypoints_list = []
#     for frame_num in range(NUM_FRAMES):
#         file_path = os.path.join(action_path, f"{frame_num}.npy")
#         if not os.path.exists(file_path):
#             print(f"⚠️ 누락된 프레임 파일: {file_path}")
#             break

#         angles = np.load(file_path)  # ✅ 여기서 keypoint → angles
#         keypoints_list.append(angles)
    
#     if len(keypoints_list) == NUM_FRAMES:
#         sequences.append(keypoints_list)
#         labels.append(label_map[action])
#         valid_actions.append(action)

# actions = np.array(valid_actions)

# # numpy 배열 변환
# X = np.array(sequences)  # shape: (샘플 수, 90, 6)
# y = to_categorical(labels).astype(int)

# # 시드 고정
# np.random.seed(42)
# tf.random.set_seed(42)

# # ✅ 데이터 증강 (살짝만 흔들고, 스케일 변화 주기)
# def augment_data(X):
#     X_aug = []
#     for x in X:
#         shift = np.random.randint(-3, 3)
#         x_shifted = np.roll(x, shift, axis=0)

#         noise = np.random.normal(0, 1.5, x.shape)  # 각도라서 noise 크기 조절
#         x_noisy = x_shifted + noise

#         scale_factor = np.random.uniform(0.9, 1.1)
#         x_scaled = x_noisy * scale_factor

#         X_aug.append(x_scaled)
    
#     return np.array(X_aug)

# # 데이터 분할
# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# # 정규화 (0~180 사이일 것으로 가정, 혹은 np.max 사용도 가능)
# X_train_aug = augment_data(X_train)
# X_train_aug = X_train_aug / 180.0
# X_test = X_test / 180.0

# # 배치 로딩
# BATCH_SIZE = 32
# BUFFER_SIZE = 1000

# train_dataset = (
#     tf.data.Dataset.from_tensor_slices((X_train_aug, y_train))
#     .shuffle(BUFFER_SIZE)
#     .batch(BATCH_SIZE)
#     .prefetch(tf.data.AUTOTUNE)
# )

# test_dataset = (
#     tf.data.Dataset.from_tensor_slices((X_test, y_test))
#     .batch(BATCH_SIZE)
#     .prefetch(tf.data.AUTOTUNE)
# )

# # 콜백 설정
# early_stopping = EarlyStopping(monitor='loss', patience=20, min_delta=0.0005, verbose=1, restore_best_weights=True)
# reduce_lr = ReduceLROnPlateau(monitor='loss', factor=0.5, patience=5, min_lr=1e-4, verbose=1)

# # ✅ 모델 구조 변경 (입력 shape 수정됨!)
# model = Sequential([
#     Conv1D(64, 3, activation='relu', input_shape=(NUM_FRAMES, NUM_ANGLES)),
#     MaxPooling1D(2),
#     Conv1D(64, 3, activation='relu'),
#     MaxPooling1D(2),
#     Flatten(),
#     Dense(32, activation='relu'),
#     Dense(y.shape[1], activation='softmax')
# ])

# model.compile(
#     optimizer=Adam(learning_rate=0.0005),
#     loss='categorical_crossentropy',
#     metrics=['categorical_accuracy']
# )

# model.fit(train_dataset, epochs=2000, callbacks=[early_stopping, reduce_lr])
# model.save('90frames_angles.keras')  # ✅ 파일명도 구분되게
