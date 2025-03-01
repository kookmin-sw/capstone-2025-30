import os
import cv2
import numpy as np
import pandas as pd
import mediapipe as mp
import tensorflow as tf
from PIL import ImageFont, ImageDraw, Image
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
3. 예측 실행
"""
# 모델 불러오기
best_1DCNN_model = tf.keras.models.load_model('mediapipe_dl.keras')

# 이미지 처리 함수
def process_frame(image_data):
    # base64 형식의 이미지 데이터를 bytes로 디코딩
    image_bytes = base64.b64decode(image_data)

    # bytes를 NumPy 배열로 변환
    np_arr = np.frombuffer(image_bytes, np.uint8)

    # NumPy 배열을 이미지로 변환
    img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

    # 이미지 처리 로직 수행
    # 예시로 그레이스케일 변환을 수행합니다.
    # gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # 처리된 이미지를 다시 base64 형식으로 인코딩
    # _, encoded_img = cv2.imencode('.jpg', gray_img)
    # processed_image_data = base64.b64encode(encoded_img).decode('utf-8')

    return img

# 동작 인식 실행 함수
def extract_from_wc():
    sequence = []
    sentence = []
    threshold = 0.95

    video = cv2.VideoCapture(1)

    with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
        while video.isOpened():
            ret, img = video.read()

            if not ret:
                break
            
            # 이미지를 base64 형식으로 인코딩
            _, buffer = cv2.imencode('.jpg', img)
            image_data = base64.b64encode(buffer).decode('utf-8')

            # base64로 인코딩된 이미지를 process_frame 함수에 전달
            img = process_frame(image_data)

            # Mediapipe 모델로 이미지 처리
            img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
            results = holistic.process(img_rgb)

            # 원본 이미지 복사
            img = cv2.cvtColor(img_rgb, cv2.COLOR_RGB2BGR)

            # 키포인트 추출
            keypoints = extract_keypoints(results)
            sequence.append(keypoints)
            sequence = sequence[-30:]  # 최대 프레임 수로 조정

            # Mediapipe 키포인트 그리기
            if results.face_landmarks:
                mp_drawing.draw_landmarks(img, results.face_landmarks, mp_holistic.FACEMESH_CONTOURS)
            if results.pose_landmarks:
                mp_drawing.draw_landmarks(img, results.pose_landmarks, mp_holistic.POSE_CONNECTIONS)
            if results.left_hand_landmarks:
                mp_drawing.draw_landmarks(img, results.left_hand_landmarks, mp_holistic.HAND_CONNECTIONS)
            if results.right_hand_landmarks:
                mp_drawing.draw_landmarks(img, results.right_hand_landmarks, mp_holistic.HAND_CONNECTIONS)
            
            if len(sequence) == 30:  # 동영상 길이에 맞게 예측을 처리

                
                res = best_1DCNN_model.predict(np.expand_dims(sequence, axis=0))[0]
                result = actions[np.argmax(res)]
                print(actions[np.argmax(res)])
                confidence = res[np.argmax(res)]

                if confidence > threshold:
                    if len(sentence) > 0:
                        if actions[np.argmax(res)] != sentence[-1]:
                            sentence.append(actions[np.argmax(res)])
                    else:
                        sentence.append(actions[np.argmax(res)])  # 다르면 append 안한다

                if len(sentence) > 5:
                        sentence = sentence[-5:]

                # OpenCV + PIL을 이용한 한글 폰트 렌더링
                img_pil = Image.fromarray(img)
                draw = ImageDraw.Draw(img_pil)
                draw.text((10, 50), f'동작: {result}', font=font, fill=(0, 255, 0))
                draw.text((10, 100), f'확률: {confidence:.2f}', font=font, fill=(255, 255, 0))

                # 화면에 예측된 단어들 보여주기
                # if sentence:
                #     sentence_text = " ".join(sentence)
                #     draw.text((10, 150), f'예측된 단어: {sentence_text}', font=font, fill=(0, 255, 255))

                img = np.array(img_pil)

            # 화면 출력
            cv2.imshow('Sign Language Recognition', img)
            # print(' '.join(sentence))

            # 키 입력에 따라 동작 설정
            key = cv2.waitKey(1) & 0xFF

            # # '0'을 눌렀을 때 sentence 초기화
            # if key == ord('0'):
            #     sentence = []

            # # '1'을 눌렀을 때 예측된 단어 화면에 표시
            # if key == ord('1'):
            #     sentence_text = " ".join(sentence)
            #     print(f"예측된 단어: {sentence_text}")

            # 'q'를 눌렀을 때 종료
            if key == ord('q'):
                break

    video.release()
    cv2.destroyAllWindows()

# 실행
extract_from_wc()
