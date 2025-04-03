# 빌드 스테이지
FROM golang:1.22-alpine AS builder

WORKDIR /app

# go.mod, go.sum 복사
COPY go.mod go.sum ./
RUN go mod download

# server 내부 코드 복사
COPY . .

# 루트 기준 cmd/server 복사 (밖에서 가져와야 함)
COPY ../cmd ./cmd

# proto 경로도 필요하면 추가
COPY ../proto ./proto

# 빌드
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/server

# 실행 스테이지
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/.env .

CMD ["./main"]
