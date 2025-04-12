package grpcHandler

import (
	"context"
	"fmt"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"net"
	"os"
	pb "server/gen"
	"time"
)

type Server struct {
	pb.UnimplementedAPIServiceServer
	AiClient pb.SignAIClient
}

func Initialize() error {
	port := os.Getenv("GRPC_PORT")
	logrus.Debugln("port: ", port)
	address := fmt.Sprintf(":%s", port)

	lis, err := net.Listen("tcp", address)
	if err != nil {
		logrus.Errorln("failed to listen: %v", err)
	}

	aiHost := os.Getenv("AI_GRPC_HOST")
	if aiHost == "" {
		logrus.Errorln("AI_GRPC_HOST is not set")
		return fmt.Errorf("AI_GRPC_HOST is not set")
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	conn, err := grpc.DialContext(ctx, aiHost, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		logrus.Fatal("failed to connect to AI gRPC server: %v", err)
	}
	aiClient := pb.NewSignAIClient(conn)

	// 인증 인터셉터
	s := grpc.NewServer(
		grpc.UnaryInterceptor(KeyAuthInterceptor),
	)

	pb.RegisterAPIServiceServer(s, &Server{
		AiClient: aiClient,
	})

	logrus.Println("server listening at %v", lis.Addr())

	initializeFailed := make(chan bool)
	go func() {
		err := s.Serve(lis)
		if err != nil {
			close(initializeFailed)
		}
	}()

	select {
	case <-initializeFailed:
		logrus.Debugln("Server failed to start.")
		return err
	default:
		logrus.Debugln("Server is running...")
	}

	select {}
}
