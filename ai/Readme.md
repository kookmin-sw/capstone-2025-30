## 📁 파일 구조

문의하기 (GRPC)

```
📁 ai
├── 📁 docs
├── 📁 gesture_dict
├── 📁 grpc
│   └── 📁 proto
├── 📁 saved_frames
├── 📄 all_predict_korean_client.py         # 전체 영상 대상 예측 - 한국어 클라이언트
├── 📄 all_predict_sign_client.py           # 전체 영상 대상 예측 - 일반 수어 클라이언트
├── 📄 all_predict_sign_pb2_grpc.py         # 전체 영상 대상 예측 - gRPC 설정
├── 📄 all_predict_sign_pb2.py              # 전체 영상 대상 예측 - gRPC 설정
├── 📄 all_predict_sign_server.py           # 전체 영상 대상 예측 - 서버
├── 📄 load_sim.py                          # 한국수어 변환시에 존재하지 않은 한국어 단어 존재 시에 유사한 단어를 데이터 셋에서 찾아줌
├── 📄 load_to_korean_rag.py                # 한국어로 변환하는 RAG 데이터 로딩
├── 📄 load_to_sign_rag.py                  # 수어로 변환하는 RAG 데이터 로딩
├── 📄 predict_sign_client.py               # 동작 단위 예측 - 클라이언트
├── 📄 predict_sign_pb2_grpc.py             # 동작 단위 예측 - gRPC 설정
├── 📄 predict_sign_pb2.py                  # 동작 단위 예측 - gRPC 설정
├── 📄 predict_sign_server.py               # 동작 단위 예측 - 서버
└── 📄 아메리카노_수어통합본.mp4                  # 테스트용 수어 영상

📁 inqury
📁 menu
📁 models 

```

---
<details>
    <summary> .env </summary>

Docker 실행 전에 .env 파일을 생성하신 후에 아래 내용을 넣어주셔야 합니다.

```
OPENAPI_URL = "http://api.kcisa.kr/openapi/service/rest/meta13/getCTE01701"
OPENAPI_KEY = "슬랙 컨버스 참고"

OPEN_AI_KEY="슬랙 컨버스 참고"

MONGO_DB_URL = "슬랙 컨버스 참고"

SPREADSHEET_ID = "슬랙 컨버스 참고"
SPREADSHEET_JSON_KEY = "슬랙 컨버스 참고"
HF_TOKEN = "슬랙 컨버스 참고"
```

</details>


---

(GRPC) HOW TO USE

#### 1. docker 서버 실행

```
docker-compose up --build
```

#### 2. 한국 수어 -> 한국어 문장 번역 실행
```
# grpc 디렉토리에 들어가서 
python3 all_predict_sign_client.py
```

#### 3. 한국어 문장 -> 한국 수어 번역 실행
```
# grpc 디렉토리에 들어가서 
python3 all_predict_korean_client.py
```

---