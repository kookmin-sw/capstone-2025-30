import cv2
import grpc
import os
import all_predict_sign_pb2
import all_predict_sign_pb2_grpc

channel = grpc.insecure_channel('localhost:50051',
                                  options=[('grpc.max_send_message_length', 10 * 1024 * 1024 * 10),  # 100MB
                                           ('grpc.max_receive_message_length', 10 * 1024 * 1024 * 10)])  # 100MB
stub = all_predict_sign_pb2_grpc.SignAIStub(channel)

video_path = '아메리카노_수어통합본.mp4'
cap = cv2.VideoCapture(video_path)
if not cap.isOpened():
    print("❌ 비디오를 열 수 없습니다.")
    exit()

fps = cap.get(cv2.CAP_PROP_FPS)
frame_count = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
video_length = frame_count / fps
print(f"비디오 FPS: {fps}")

frames = []

while True:
    ret, frame = cap.read()
    if not ret:
        break

    success, buffer = cv2.imencode('.jpg', frame)
    if success:
        frame_bytes = buffer.tobytes()
        frames.append(frame_bytes)

cap.release()

if len(frames) == 0:
    print("⚠️ 전송할 프레임이 없습니다.")
    exit()


# Client : 프레임 별로 저장하는 코드
save_dir = "saved_frames"
os.makedirs(save_dir, exist_ok=True)

for idx, frame_bytes in enumerate(frames):
    frame_path = os.path.join(save_dir, f"frame_{idx:05d}.jpg") 
    with open(frame_path, 'wb') as f:
        f.write(frame_bytes)

print(f"✅ 총 {len(frames)}개의 프레임이 '{save_dir}' 폴더에 저장되었습니다.")

frame_files = sorted([f for f in os.listdir(save_dir) if f.endswith('.jpg')])

# Server : jpg 들을 읽어서 한 배열에 묶어주는 코드
frames = []
for file_name in frame_files:
    frame_path = os.path.join(save_dir, file_name)
    with open(frame_path, 'rb') as f:
        frame_bytes = f.read()
        frames.append(frame_bytes)


request = all_predict_sign_pb2.FrameSequenceInput(
    frames=frames,
    client_id="client_01",
    fps=fps,
    video_length=video_length
)


response = stub.PredictFromFrames(request)

print(f"[예측 결과] Client: {response.client_id}, 한국어 문장: {response.predicted_sentence}")
