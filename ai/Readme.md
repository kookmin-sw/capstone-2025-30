## 🔎 실행 방법

---
<details>
    <summary> .env </summary>

(각자 OpenAI에서 API Key를 발급 받으신 후에 넣어주셔야 합니다)
필수 범위 :  한국수어 -> 한국어 번역 모델 실행 (4번)

```
OPEN_AI_KEY="sk..."
```

</details>


---

(MAC 기준 window는 python3 -> python 으로 실행)

#### 1. 가상환경 생성 & 가상환경 활성화 

```
python3 -m venv venv
source venv/bin/activate
```

#### 2. 필요한 라이브러리 다운
```
pip install -r requirements.txt
```

#### 3. 웹 캠 실시간 수화 실행
```
python3 load_dl.py
```

#### 4. 한국수어 -> 한국어 번역 모델 실행
```
python3 load_rag.py
```

---