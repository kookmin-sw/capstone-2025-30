package grpcHandler

import (
	"context"
	"fmt"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"math/rand"
	pb "server/gen"
	mstore "server/internal/pkg/database/mongodb/store"
	dbstructure "server/internal/pkg/database/structure"
	"server/internal/pkg/utils"
	"time"
)

func (s *Server) CreateStore(
	ctx context.Context,
	req *pb.CreateStoreRequest,
) (
	response *pb.StoreResponse, errRes error,
) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in CreateStore grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			response = &pb.StoreResponse{Success: false, Error: pbErr.Enum()}
		}

	}()

	// 인증

	// request -> mongodb 구조체 변환
	mStore := dbstructure.MStore{
		ID:        primitive.NewObjectID(),
		Name:      req.Name,
		Location:  req.Location,
		StoreCode: generateStoreCode(8),
	}

	// db에 저장
	err := mstore.UpsertMStore(&mStore)
	if err != nil {
		panic(fmt.Errorf("failed to upsert mStore: %v", err))
	}

	// mongodb 구조체 -> grpc 구조체 변환(proto
	pStore := &pb.Store{
		Id:        mStore.ID.Hex(),
		Name:      mStore.Name,
		Location:  mStore.Location,
		StoreCode: mStore.StoreCode,
	}

	// 응답
	return &pb.StoreResponse{
		Success: true,
		Error:   nil,
		Store:   pStore,
	}, nil
}

// store_code 생성용 문자 집합
const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

// 랜덤 문자열 생성 (기본 8글자)
func generateStoreCode(length int) string {
	rand.Seed(time.Now().UnixNano())
	code := make([]byte, length)
	for i := range code {
		code[i] = charset[rand.Intn(len(charset))]
	}
	return string(code)
}
