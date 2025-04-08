package grpcHandler

import (
	"fmt"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/grpc/reflection"
	"net"
	"os"
	pb "server/gen"
	"server/internal/pkg/database/mongodb"
	storeGrpc "server/internal/pkg/grpc/store"
)

// Initialize
func Initialize() (*grpc.ClientConn, error) {
	// 1. gRPC 서버 실행
	go func() {
		port := os.Getenv("GRPC_PORT")
		lis, err := net.Listen("tcp", ":"+port)
		if err != nil {
			logrus.Fatalf("failed to listen: %v", err)
		}

		server := grpc.NewServer()

		// StoreService 등록
		pb.RegisterStoreServiceServer(server, &storeGrpc.StoreHandler{
			MongoClient: mongodb.Client,
		})
		pb.RegisterAPIServiceServer(server, &Server{}) // Server는 grpcHandler.Server 타입

		reflection.Register(server)
		logrus.Infof("gRPC server listening on port %s", port)

		if err := server.Serve(lis); err != nil {
			logrus.Fatalf("failed to serve: %v", err)
		}
	}()

	// 2. gRPC 클라이언트 연결 반환
	conn, err := grpc.Dial("localhost:"+os.Getenv("GRPC_PORT"), grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		return nil, fmt.Errorf("failed to connect to gRPC: %w", err)
	}

	return conn, nil
}
