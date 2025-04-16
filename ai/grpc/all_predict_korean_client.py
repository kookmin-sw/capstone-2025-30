import grpc
import all_predict_sign_pb2
import all_predict_sign_pb2_grpc

def run():
    channel = grpc.insecure_channel('localhost:50051')
    stub = all_predict_sign_pb2_grpc.SignAIStub(channel)

    request = all_predict_sign_pb2.KoreanInput(
        message="커피에 설탕 한 개 넣어 주세요",
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
