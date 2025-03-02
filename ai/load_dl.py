import os
import cv2
import numpy as np
import pandas as pd
import mediapipe as mp
import tensorflow as tf
from PIL import ImageFont, ImageDraw, Image
import base64
import time

raw_data = pd.read_csv("dataset.csv")
DATA_PATH = os.path.join('holistic_dataset')
# gesture = {i: title for i, title in enumerate(raw_data["Title"])}

# 훈련을 위한 데이터 셋의 라벨링 작업
urls = raw_data['SubDescription'][:100]
actions = raw_data["Title"][:100].tolist()
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
best_1DCNN_model = tf.keras.models.load_model('all_mediapipe_dl.keras')

# 이미지 처리 함수
def process_frame(image_data):
    # base64 형식의 이미지 데이터를 bytes로 디코딩
    image_bytes = base64.b64decode(image_data)

    # bytes를 NumPy 배열로 변환
    np_arr = np.frombuffer(image_bytes, np.uint8)

    # NumPy 배열을 이미지로 변환
    img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

    return img

def calculate_keypoint_change(keypoints1, keypoints2):
    """
    두 개의 keypoints 리스트를 비교하여 변화량을 계산하는 함수.
    변화량은 각 keypoint 간의 유클리드 거리의 합으로 정의합니다.
    """
    total_change = 0
    for kp1, kp2 in zip(keypoints1, keypoints2):
        if kp1 is not None and kp2 is not None:
            distance = np.linalg.norm(np.array(kp1) - np.array(kp2))
            total_change += distance
    return total_change

# 동작 인식 실행 함수
def extract_from_wc():
    sequence = []
    sentence = []
    previous_keypoints = None
    previous_result = None
    threshold = 0.95
    last_return_time = None 
    to_rag_sentence_list = []  # 순서 유지용 list
    change_threshold = 1.5  # 임계값
    stable_count = 0
    stable_threshold = 5  # 최소 5회 연속 같은 동작이 감지되면 확정

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
                confidence = res[np.argmax(res)]

                if (confidence > threshold) and (results.left_hand_landmarks or results.right_hand_landmarks):
                    if len(sentence) > 0:
                        if actions[np.argmax(res)] != sentence[-1]:
                            sentence.append(actions[np.argmax(res)])
                    else:
                        sentence.append(actions[np.argmax(res)])  # 다르면 append 안한다
                    print(result)

                if len(sentence) > 5:
                    sentence = sentence[-5:]
                
                 # OpenCV + PIL을 이용한 한글 폰트 렌더링
                img_pil = Image.fromarray(img)
                draw = ImageDraw.Draw(img_pil)

                # 이전 키포인트와의 변화량을 계산
                if previous_keypoints is not None and (sentence and (results.left_hand_landmarks or results.right_hand_landmarks)):
                    change = calculate_keypoint_change(previous_keypoints, keypoints)
                    print(f"변화량: {change}")

                    # 변화량이 일정 임계값 이하일 때
                    if change < change_threshold:  # 임계값 조정
                        if confidence > 0.97:
                            if result != previous_result and result not in to_rag_sentence_list[-3:]:
                                print("!! Return 조건 충족 !!")
                                last_return_time = time.time()                                
                                # 2초 후에 Return 동작 표시
                                draw.text((10, 100), f'확률: {confidence:.2f}', font=font, fill=(255, 255, 0))
                                draw.text((10, 150), f'Return 동작: {result}', font=font, fill=(0, 255, 255))
                                to_rag_sentence_list.append(result) 
                                previous_result = result
                
                # 실시간으로 예측되는 수어를 확인하는 코드
                if last_return_time and (time.time() - last_return_time < 2):
                    draw.text((10, 100), f'확률: {confidence:.2f}', font=font, fill=(255, 255, 0))
                    draw.text((10, 150), f'Return 동작: {result}', font=font, fill=(0, 255, 255))
                
                previous_keypoints = keypoints
                
                img = np.array(img_pil)

            # 화면 출력
            cv2.imshow('Sign Language Recognition', img)

            # 키 입력에 따라 동작 설정
            key = cv2.waitKey(1) & 0xFF

            # 'q'를 눌렀을 때 종료
            if key == ord('q'):  # 'q' 키가 눌렸을 때
                with open("output.txt", "w", encoding="utf-8") as f:  # UTF-8로 저장
                    for sentence in to_rag_sentence_list:
                        f.write(sentence + "\n")  # 한 줄씩 저장
                print("저장 완료: output.txt")
                break  # 루프 종료


    video.release()
    cv2.destroyAllWindows()

# 실행
extract_from_wc()
