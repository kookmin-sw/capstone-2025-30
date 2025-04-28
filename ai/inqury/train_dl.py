import os
from dotenv import load_dotenv
from pymongo import MongoClient
import numpy as np
import json
import matplotlib.pyplot as plt


from sklearn.model_selection import train_test_split
from sklearn.utils.class_weight import compute_class_weight

from tensorflow.keras.layers import Masking, LSTM, Dense, Input, Dropout
from tensorflow.keras.utils import to_categorical

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


DATA_PATH = "angles"
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
        ModelCheckpoint('90_v2_masked_angles.h5', monitor='val_acc', verbose=1, save_best_only=True, mode='auto'),
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
acc_ax.legend(loc='upper right')

plt.title('Model Training History')
plt.grid(True)
plt.show()

# 모델 저장
model.save('90_v2_masked_angles.h5')
print("✅ 모델 저장 완료: 90_v2_masked_angles.h5")

# 제스처 라벨 딕셔너리 저장
with open('v2_pad_gesture_dict.json', 'w', encoding='utf-8') as f:
    json.dump(gesture, f, ensure_ascii=False, indent=2)
print("✅ 제스처 라벨 딕셔너리 저장 완료: v2_pad_gesture_dict.json")