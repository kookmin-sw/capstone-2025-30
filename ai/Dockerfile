FROM python:3.10

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade --no-deps -r requirements.txt
RUN apt-get update && apt-get install -y libgl1

COPY . .
EXPOSE 50051

CMD ["python", "grpc/all_predict_sign_server.py"]