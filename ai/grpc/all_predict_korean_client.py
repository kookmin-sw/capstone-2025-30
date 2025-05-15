import grpc
import all_predict_sign_pb2
import all_predict_sign_pb2_grpc
from dotenv import load_dotenv
import os
import time

load_dotenv()
host = os.getenv("AI_EC2_HOST")
env = os.getenv('APP_ENV', 'local')
trusted_certs = os.environ['AI_TLS_CRT'].encode('utf-8')

def run():
    if env == 'production':
        credentials = grpc.ssl_channel_credentials(root_certificates=trusted_certs)
        channel = grpc.secure_channel(f"{host}:50051", credentials)
    else:
        channel = grpc.insecure_channel(f"localhost:50051")
    stub = all_predict_sign_pb2_grpc.SignAIStub(channel)

    request = all_predict_sign_pb2.KoreanInput(
        # message="지금은 자리가 꽉차서 조금 기다려주셔야 합니다.",
        message="나이프 더 주세요",
        store_id="store_01"
    )

    start_time = time.time()

    try:
        response = stub.TranslateKoreanToSignUrls(request)
        
        end_time = time.time()
        
        elapsed_time_ms = (end_time - start_time) * 1000
        print(f"✅ 예측된 수어 URL 리스트 (응답 시간: {elapsed_time_ms:.2f} ms):")
        
        for url in response.urls:
            print(" -", url)
    except grpc.RpcError as e:
        print("❌ RPC 에러:", e.details())

if __name__ == '__main__':
    run()
