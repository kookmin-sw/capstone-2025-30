package grpcHandler

import (
	"context"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
	"os"
)

func KeyAuthInterceptor(ctx context.Context, req any, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (resp interface{}, err error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in UnaryServerInterceptor : ", r)
		}
	}()

	mk, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		logrus.Warn("metadata not found")
		return nil, status.Errorf(codes.Unauthenticated, "metadata not found")
	}

	var authKey string
	if values := mk["auth_key"]; len(values) > 0 {
		authKey = values[0]
	} else {
		logrus.Warn("auth_key not found in metadata")
		return nil, status.Errorf(codes.Unauthenticated, "auth_key not found in metadata")
	}

	allowedKey := os.Getenv("ALLOWED_AUTH_KEY")

	if authKey != allowedKey {
		logrus.Warn("invalid auth_key")
		return nil, status.Errorf(codes.PermissionDenied, "invalid auth_key")
	}

	logrus.Infof("Authorized request with key: %s", authKey)

	resp, err = handler(ctx, req)

	if err != nil {
		logrus.Errorf("RPC failed with error %v", err)
	}

	return resp, err
}
