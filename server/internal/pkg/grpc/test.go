package grpcHandler

import (
	"context"
	"github.com/sirupsen/logrus"
	pb "server/gen"
)

func (s *Server) AddTestStruct(
	ctx context.Context,
	req *pb.AddTestStructRequest,
) (
	response *pb.AddTestStructResponse, errRes error,
) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in AddTestStruct : ", r)
			// recover to EError?
			response = &pb.AddTestStructResponse{
				Success: false,
			}
			errRes = nil
		}
	}()

	// keyauth 검증

	return &pb.AddTestStructResponse{
		Success: true,
	}, nil
}
