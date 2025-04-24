import grpc
import all_predict_sign_pb2
import all_predict_sign_pb2_grpc
from dotenv import load_dotenv
import os

load_dotenv()
host = os.getenv("AI_EC2_HOST")
trusted_certs = os.environ['AI_TLS_CRT'].encode('utf-8')

def run():
    credentials = grpc.ssl_channel_credentials(root_certificates=trusted_certs)
    channel = grpc.secure_channel(f"{host}:50051", credentials)
    # channel = grpc.secure_channel(f"localhost:50051", credentials)
    stub = all_predict_sign_pb2_grpc.SignAIStub(channel)

    request = all_predict_sign_pb2.KoreanInput(
        message="현재 카페 자리가 없어요",
        client_id="client_01"
    )

    try:
        response = stub.TranslateKoreanToSignUrls(request)
        print("✅ 예측된 수어 URL 리스트:")
        for url in response.urls:
            print(" -", url)
    except grpc.RpcError as e:
        print("❌ RPC 에러:", e.details())

if __name__ == '__main__':
    run()
