package grpcHandler

import (
	"context"
	"fmt"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/emptypb"
	"math/rand"
	pb "server/gen"
	mstore "server/internal/pkg/database/mongodb/store"
	dbstructure "server/internal/pkg/database/structure"
	"server/internal/pkg/utils"
	"time"
)

func (s *Server) CreateStore(ctx context.Context, req *pb.CreateStoreRequest) (response *pb.CreateStoreResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in CreateStore grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			response = &pb.CreateStoreResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	mStore := dbstructure.MStore{
		ID:        primitive.NewObjectID(),
		Name:      req.Name,
		Location:  req.Location,
		StoreCode: generateStoreCode(8),
	}

	err := mstore.CreateMStore(&mStore)
	if err != nil {
		panic(fmt.Errorf("failed to create mStore: %v", err))
	}

	return &pb.CreateStoreResponse{
		Success: true,
		Error:   nil,
		Store:   toViewStore(&mStore),
	}, nil
}

func (s *Server) GetStoreList(ctx context.Context, req *emptypb.Empty) (response *pb.GetStoreListResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetStoreList grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			response = &pb.GetStoreListResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	mStores, err := mstore.GetMStoreList()
	if err != nil {
		panic(fmt.Errorf("failed to get store list from mStore: %v", err))
	}

	var viewStores []*pb.ViewStore
	for _, m := range mStores {
		viewStores = append(viewStores, toViewStore(&m))
	}

	return &pb.GetStoreListResponse{
		Success: true,
		Error:   nil,
		Stores:  viewStores,
	}, nil
}

func (s *Server) GetStore(ctx context.Context, req *pb.GetStoreRequest) (response *pb.GetStoreResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetStore grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			response = &pb.GetStoreResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mStore, err := mstore.GetMStore(storeID)
	if err != nil {
		panic(fmt.Errorf("failed to get mStore: %v", err))
	}

	if mStore == nil {
		return &pb.GetStoreResponse{
			Success: false,
			Error:   pb.EError_EE_API_FAILED.Enum(),
		}, status.Errorf(codes.NotFound, "store not found: %s", req.StoreCode)
	}

	return &pb.GetStoreResponse{
		Success: true,
		Error:   nil,
		Store:   toViewStore(mStore),
	}, nil
}

func (s *Server) UpdateStore(ctx context.Context, req *pb.UpdateStoreRequest) (response *pb.UpdateStoreResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in UpdateStore grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			response = &pb.UpdateStoreResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}
	mStore := dbstructure.MStore{
		ID:       storeID,
		Name:     name,
		Location: location,
	}

	err = mstore.UpdateMStore(&mStore)
	if err != nil {
		panic(fmt.Errorf("failed to update mStore: %v", err))
	}

	return &pb.UpdateStoreResponse{
		Success: true,
		Error:   nil,
		Store:   toViewStore(&mStore),
	}, nil
}

func (s *Server) DeleteStore(ctx context.Context, req *pb.DeleteStoreRequest) (response *pb.DeleteStoreResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in DeleteStore grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			response = &pb.DeleteStoreResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	err = mstore.DeleteMStore(storeID)
	if err != nil {
		panic(fmt.Errorf("failed to delete mStore: %v", err))
	}

	return &pb.DeleteStoreResponse{
		Success: true,
		Error:   nil,
	}, nil
}

// View 변환 헬퍼 함수
func toViewStore(m *dbstructure.MStore) *pb.ViewStore {
	return &pb.ViewStore{
		StoreCode: m.StoreCode,
		Name:      m.Name,
		Location:  m.Location,
	}
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
