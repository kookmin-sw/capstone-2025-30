package grpcHandler

import (
	"fmt"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"net"
	"os"
	pb "server/gen"
)

var ()

type Server struct {
	pb.UnimplementedAPIServiceServer
}

func Initialize() error {
	port := os.Getenv("GRPC_PORT")
	logrus.Debugln("port: ", port)
	address := fmt.Sprintf(":%s", port)

	lis, err := net.Listen("tcp", address)
	if err != nil {
		logrus.Errorln("failed to listen: %v", err)
	}

	// 인증 인터셉터 : 현재 생략
	s := grpc.NewServer(
		grpc.UnaryInterceptor(KeyAuthInterceptor),
	)

	pb.RegisterAPIServiceServer(s, &Server{})
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
