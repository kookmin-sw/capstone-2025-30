import mediapipe as mp
import tensorflow as tf
import cv2
import numpy as np
from PIL import ImageFont, ImageDraw, Image

import json

with open('v6_pad_gesture_dict.json', 'r', encoding='utf-8') as f:
    gesture_dict = json.load(f)

actions = [gesture_dict[str(i)] for i in range(len(gesture_dict))]

seq_length = 90

model = tf.keras.models.load_model('../models/90_v6_masked_angles.h5')
print(model.input_shape)


MAX_NUM_HANDS = 2
mp_hands=mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils

hands=mp_hands.Hands(
    max_num_hands=MAX_NUM_HANDS, 
    min_detection_confidence=0.5, 
    min_tracking_confidence=0.5 
)

cap = cv2.VideoCapture(1)
if not cap.isOpened():
    print("웹캠을 열 수 없습니다.")
    exit()


seq = []
action_seq = []

font_path = "/Library/Fonts/AppleGothic.ttf"
font = ImageFont.truetype(font_path, 32)



while cap.isOpened():
    ret, img = cap.read()
    img0 = img.copy()

    img = cv2.flip(img, 1)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    result = hands.process(img)
    img = cv2.cvtColor(img, cv2.COLOR_RGB2BGR)

    if result.multi_hand_landmarks is not None:
        for res in result.multi_hand_landmarks:
            joint = np.zeros((21, 3))
            for j, lm in enumerate(res.landmark):
                joint[j] = [lm.x, lm.y, lm.z]

            v1 = joint[[0,1,2,3,0,5,6,7,0,9,10,11,0,13,14,15,0,17,18,19], :3] 
            v2 = joint[[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20], :3] 
            v = v2 - v1 
            v = v / np.linalg.norm(v, axis=1)[:, np.newaxis]

            angle = np.arccos(np.einsum('nt,nt->n',
                v[[0,1,2,4,5,6,8,9,10,12,13,14,16,17,18],:], 
                v[[1,2,3,5,6,7,9,10,11,13,14,15,17,18,19],:])) 

            angle = np.degrees(angle) 

            d = np.concatenate([joint.flatten(), angle])

            seq.append(d)

            mp_drawing.draw_landmarks(img, res, mp_hands.HAND_CONNECTIONS)

            if len(seq) < seq_length:
                continue

            input_data = np.expand_dims(np.array(seq[-seq_length:], dtype=np.float32), axis=0)
            print(input_data.shape) 


            y_pred = model.predict(input_data).squeeze()

            i_pred = int(np.argmax(y_pred))
            conf = y_pred[i_pred]

            if conf < 0.5:
                continue

            action = actions[i_pred]
            action_seq.append(action)

            if len(action_seq) < 3:
                continue

            this_action = '?'
            if action_seq[-1] == action_seq[-2] == action_seq[-3]:
                this_action = action

            pil_img = Image.fromarray(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
            draw = ImageDraw.Draw(pil_img)


            text_position = (int(res.landmark[0].x * img.shape[1]), int(res.landmark[0].y * img.shape[0] + 20))
            draw.text(text_position, this_action, font=font, fill=(255, 255, 255))

            img = cv2.cvtColor(np.array(pil_img), cv2.COLOR_RGB2BGR)

    cv2.imshow('img', img)
    if cv2.waitKey(1) == ord('q'):
        break