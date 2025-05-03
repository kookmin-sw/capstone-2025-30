package grpcHandler

import (
	"context"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson/primitive"
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
			logrus.Error("[gRPC CreateStore] panic: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			response = &pb.CreateStoreResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	exists, err := mstore.IsStoreExists(req.Name, req.Location)
	if err != nil {
		panic(err)
	}
	if exists {
		logrus.Errorf("[gRPC CreateStore] Store already exists")
		panic(pb.EError_EE_MENU_ALREADY_EXISTS)
	}

	mStore := dbstructure.MStore{
		ID:        primitive.NewObjectID(),
		Name:      req.Name,
		Location:  req.Location,
		StoreCode: generateStoreCode(8),
	}

	err = mstore.CreateMStore(&mStore)

	if err != nil {
		logrus.Errorf("[gRPC CreateStore] Failed to create store")
		panic(err)
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
			logrus.Error("[gRPC GetStoreList] panic: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			response = &pb.GetStoreListResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	mStores, err := mstore.GetMStoreList()
	if err != nil {
		logrus.Errorf("[gRPC GetStoreList] Failed to get store list: %v", err)
		panic(pb.EError_EE_DB_OPERATION_FAILED)
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
			logrus.Error("[gRPC GetStore] panic:: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			response = &pb.GetStoreResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		logrus.Errorf("[gRPC GetStore] Store Id is not founded by store code(%s): %v", req.StoreCode, err)
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mStore, err := mstore.GetMStore(storeID)
	if err != nil {
		logrus.Errorf("[gRPC GetStore] Failed to get store by ID(%s): %v", storeID.Hex(), err)
		panic(pb.EError_EE_DB_OPERATION_FAILED)
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
			logrus.Error("[gRPC UpdateStore] panic: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			response = &pb.UpdateStoreResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		logrus.Errorf("[gRPC UpdateStore] Store Id is not founded by store code(%s): %v", req.StoreCode, err)
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	oldStore, err := mstore.GetMStore(storeID)
	if err != nil {
		logrus.Error("[gRPC UpdateStore] Failed to get store")
		panic(pb.EError_EE_DB_OPERATION_FAILED)
	}

	name := req.Name
	location := req.Location

	if name == "" {
		name = oldStore.Name
	}

	if location == "" {
		location = oldStore.Location
	}

	mStore := dbstructure.MStore{
		ID:       storeID,
		Name:     name,
		Location: location,
	}

	err = mstore.UpdateMStore(&mStore)
	if err != nil {
		logrus.Errorf("[gRPC UpdateStore] Failed to update store %s: %v", req.StoreCode, err)
		panic(pb.EError_EE_DB_OPERATION_FAILED)
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
			logrus.Error("[gRPC DeleteStore] panic: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			response = &pb.DeleteStoreResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		logrus.Errorf("[gRPC DeleteStore] Store Id is not founded by store code(%s): %v", req.StoreCode, err)
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	err = mstore.DeleteMStore(storeID)
	if err != nil {
		logrus.Errorf("[gRPC DeleteStore] Failed to delete store %s: %v", storeID.Hex(), err)
		panic(pb.EError_EE_DB_OPERATION_FAILED)
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
