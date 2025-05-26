FROM python:3.10

WORKDIR /app

RUN python -m venv /env
ENV PATH="/env/bin:$PATH"

COPY requirements.txt .
RUN pip install --upgrade pip

# torch CPU 버전 따로 설치
RUN pip install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 \
    -f https://download.pytorch.org/whl/cpu/torch_stable.html

RUN pip install --no-cache-dir --upgrade --no-deps -r requirements.txt

RUN apt-get update && apt-get install -y libgl1

COPY . .
EXPOSE 50051

CMD ["python", "-u", "grpc/all_predict_sign_server.py"]
