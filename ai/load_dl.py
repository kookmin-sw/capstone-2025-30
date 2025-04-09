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


from sklearn.model_selection import train_test_split
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Flatten, Conv1D, MaxPooling1D
from tensorflow.keras.callbacks import ReduceLROnPlateau
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.callbacks import EarlyStopping

from PIL import ImageFont, ImageDraw, Image

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

font_path = "/Library/Fonts/AppleGothic.ttf"
font = ImageFont.truetype(font_path, 32)

def draw_landmarks(image, results):  # Draw face connections
    mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_holistic.POSE_CONNECTIONS)  # Draw pose connections
    mp_drawing.draw_landmarks(image, results.left_hand_landmarks,
                              mp_holistic.HAND_CONNECTIONS)  # Draw left hand connections
    mp_drawing.draw_landmarks(image, results.right_hand_landmarks,
                              mp_holistic.HAND_CONNECTIONS)  # Draw right hand connections


def draw_styled_landmarks(image, results):
    # Draw pose connections
    mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_holistic.POSE_CONNECTIONS,
                              mp_drawing.DrawingSpec(color=(80, 22, 10), thickness=2, circle_radius=4),
                              mp_drawing.DrawingSpec(color=(80, 44, 121), thickness=2, circle_radius=2)
                              )
    # Draw left hand connections
    mp_drawing.draw_landmarks(image, results.left_hand_landmarks, mp_holistic.HAND_CONNECTIONS,
                              mp_drawing.DrawingSpec(color=(121, 22, 76), thickness=2, circle_radius=4),
                              mp_drawing.DrawingSpec(color=(121, 44, 250), thickness=2, circle_radius=2)
                              )
    # Draw right hand connections
    mp_drawing.draw_landmarks(image, results.right_hand_landmarks, mp_holistic.HAND_CONNECTIONS,
                              mp_drawing.DrawingSpec(color=(245, 117, 66), thickness=2, circle_radius=4),
                              mp_drawing.DrawingSpec(color=(245, 66, 230), thickness=2, circle_radius=2)
                              )

DATA_PATH = "keypoints"
actions = list(name_url_dict.keys())
best_1DCNN_model = tf.keras.models.load_model('90frames_angles.keras')

# def extract_from_wc():
#     predicted_label = ''
#     confidence = 0.0
#     display_counter = 0

#     sequence_length = 90
#     keypoints_list = []

#     prediction_cooldown = 90  # ✅ 예측 후 90프레임 동안 재예측 X
#     cooldown_counter = 0

#     cap = cv2.VideoCapture(1)

#     with mp_holistic.Holistic(min_detection_confidence=0.5,
#                                min_tracking_confidence=0.5) as holistic:

#         while True:
#             ret, frame = cap.read()
#             if not ret:
#                 break

#             image_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#             results = holistic.process(image_rgb)

#             draw_styled_landmarks(frame, results)

#             keypoints = extract_keypoints(results)
#             keypoints_list.append(keypoints)

#             if cooldown_counter == 0 and len(keypoints_list) == sequence_length:
#                 input_data = np.expand_dims(keypoints_list, axis=0)
#                 res = best_1DCNN_model.predict(input_data)[0]

#                 predicted_label = actions[np.argmax(res)]
#                 confidence = res[np.argmax(res)]

#                 print(f"✅ 예측 결과: {predicted_label} ({confidence:.2f})")

#                 display_counter = 30
#                 cooldown_counter = prediction_cooldown  # ✅ 쿨다운 시작
#                 keypoints_list = []

#             if cooldown_counter > 0:
#                 cooldown_counter -= 1  # ✅ 쿨다운 감소

#             if display_counter > 0:
#                 pil_img = Image.fromarray(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
#                 draw = ImageDraw.Draw(pil_img)
#                 text = f'{predicted_label} ({confidence:.2f})'
#                 draw.text((10, 10), text, font=font, fill=(255, 0, 0))
#                 frame = cv2.cvtColor(np.array(pil_img), cv2.COLOR_RGB2BGR)
#                 display_counter -= 1

#             cv2.imshow('Sign Language Recognition', frame)

#             if cv2.waitKey(10) & 0xFF == ord('q'):
#                 break

#     cap.release()
#     cv2.destroyAllWindows()


def extract_from_wc():
    predicted_label = ''
    confidence = 0.0
    display_counter = 0

    sequence_length = 90
    angles_list = []

    prediction_cooldown = 90
    cooldown_counter = 0

    cap = cv2.VideoCapture(1)

    with mp_holistic.Holistic(min_detection_confidence=0.5,
                               min_tracking_confidence=0.5) as holistic:

        while True:
            ret, frame = cap.read()
            if not ret:
                break

            image_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = holistic.process(image_rgb)

            draw_styled_landmarks(frame, results)

            angles = extract_angles(results)
            angles_list.append(angles)

            if cooldown_counter == 0 and len(angles_list) == sequence_length:
                input_data = np.expand_dims(angles_list, axis=0) 
                res = best_1DCNN_model.predict(input_data)[0]

                predicted_label = actions[np.argmax(res)]
                confidence = res[np.argmax(res)]

                print(f"✅ 예측 결과: {predicted_label} ({confidence:.2f})")

                display_counter = 30
                cooldown_counter = prediction_cooldown
                angles_list = []

            if cooldown_counter > 0:
                cooldown_counter -= 1

            if display_counter > 0:
                pil_img = Image.fromarray(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
                draw = ImageDraw.Draw(pil_img)
                text = f'{predicted_label} ({confidence:.2f})'
                draw.text((10, 10), text, font=font, fill=(255, 0, 0))
                frame = cv2.cvtColor(np.array(pil_img), cv2.COLOR_RGB2BGR)
                display_counter -= 1

            cv2.imshow('Sign Language Recognition', frame)

            if cv2.waitKey(10) & 0xFF == ord('q'):
                break

    cap.release()
    cv2.destroyAllWindows()


extract_from_wc()