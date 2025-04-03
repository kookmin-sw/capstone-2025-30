# 빌드 스테이지
FROM golang:1.22-alpine AS builder

# 작업 디렉토리 설정
WORKDIR /app

# 의존성 파일 복사 및 다운로드
COPY go.mod go.sum ./
RUN go mod download

# 소스 코드 복사
COPY . .

# 애플리케이션 빌드
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/server

# 실행 스테이지
FROM alpine:latest

# 작업 디렉토리 설정
WORKDIR /app

# 빌드된 바이너리와 환경 변수 파일 복사
COPY --from=builder /app/main .
COPY --from=builder /app/.env .

# 애플리케이션 실행
CMD ["./main"] 