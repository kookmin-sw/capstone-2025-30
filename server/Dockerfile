# 빌드 스테이지
FROM golang:1.22-alpine AS builder

WORKDIR /app

# go.mod, go.sum 복사
COPY go.mod go.sum ./
RUN go mod download

# server 내부 코드 복사
COPY . .

# 빌드
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/myapp

# 실행 스테이지
FROM alpine:latest

WORKDIR /app

# nginx 설치 및 설정
RUN apk add --no-cache nginx && \
    mkdir -p /run/nginx && \
    mkdir -p /var/log/nginx && \
    mkdir -p /etc/nginx/conf.d

# mime.types 파일 생성
RUN echo 'types {' > /etc/nginx/mime.types && \
    echo '    text/html html htm shtml;' >> /etc/nginx/mime.types && \
    echo '    text/css css;' >> /etc/nginx/mime.types && \
    echo '    text/xml xml;' >> /etc/nginx/mime.types && \
    echo '    image/gif gif;' >> /etc/nginx/mime.types && \
    echo '    image/jpeg jpeg jpg;' >> /etc/nginx/mime.types && \
    echo '    application/javascript js;' >> /etc/nginx/mime.types && \
    echo '    application/json json;' >> /etc/nginx/mime.types && \
    echo '}' >> /etc/nginx/mime.types

# nginx 설정 복사
COPY nginx.conf /etc/nginx/nginx.conf

# 애플리케이션 및 환경 변수 복사
COPY --from=builder /app/main .

# nginx 로그 디렉토리 권한 설정
RUN chown -R nginx:nginx /var/log/nginx

# 시작 스크립트 생성
RUN echo '#!/bin/sh' > /start.sh && \
    echo 'nginx -g "daemon off;" &' >> /start.sh && \
    echo 'sleep 2' >> /start.sh && \
    echo './main' >> /start.sh && \
    chmod +x /start.sh

CMD ["/start.sh"]
