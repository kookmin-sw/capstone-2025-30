FROM python:3.10

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y libgl1

COPY . .

CMD ["python", "grpc/all_predict_sign_server.py"]