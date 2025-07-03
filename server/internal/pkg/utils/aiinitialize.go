package utils

import (
	"context"
	"crypto/tls"
	"crypto/x509"
	"encoding/base64"
	"fmt"
	"os"
	pb "server/gen"
	"time"

	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
)

var (
	AiClient pb.SignAIClient
)

func InitializeAIClient() error {
	aiHost := os.Getenv("AI_GRPC_HOST")
	if aiHost == "" {
		logrus.Errorln("AI_GRPC_HOST is not set")
		return fmt.Errorf("AI_GRPC_HOST is not set")
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	creds, err := createTLSCredentialsFromEnv()
	if err != nil {
		return fmt.Errorf("failed to create TLS credentials: %v", err)
	}

	conn, err := grpc.DialContext(ctx, aiHost, grpc.WithTransportCredentials(creds))
	if err != nil {
		return fmt.Errorf("failed to connect to AI gRPC server: %v", err)
	}

	AiClient = pb.NewSignAIClient(conn)
	logrus.Infof("AI Server Connect Success")
	return nil
}

func createTLSCredentialsFromEnv() (credentials.TransportCredentials, error) {
	b64Cert := os.Getenv("AI_TLS_CRT_SERVER")
	if b64Cert == "" {
		return nil, fmt.Errorf("AI_TLS_CRT_SERVER is not set")
	}

	certPEM, err := base64.StdEncoding.DecodeString(b64Cert)
	if err != nil {
		return nil, fmt.Errorf("failed to decode base64: %v", err)
	}

	caCertPool := x509.NewCertPool()
	if ok := caCertPool.AppendCertsFromPEM(certPEM); !ok {
		return nil, fmt.Errorf("failed to append CA certificate")
	}

	creds := credentials.NewTLS(&tls.Config{
		RootCAs: caCertPool,
	})
	return creds, nil
}

// 배포용 로그
