package store

import (
	"context"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/emptypb"
	"math/rand"
	pb "server/gen"
	"server/internal/pkg/database/mongodb"
	"server/internal/pkg/database/store"
	"time"
)

type StoreHandler struct {
	pb.UnimplementedStoreServiceServer
	MongoClient *mongo.Client
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

func (s *StoreHandler) CreateStore(ctx context.Context, req *pb.CreateStoreRequest) (*pb.StoreResponse, error) {
	logrus.Info("📡 gRPC StoreHandler.CreateStore 실행 시작")
	defer func() {
		if r := recover(); r != nil {
			logrus.Errorf("🔥 panic in StoreHandler.CreateStore: %v", r)
		}
	}()

	collection := mongodb.StoreColl
	logrus.Infof("🧱 collection: %+v", collection)

	//storeCode := generateUniqueStoreCode(ctx)
	storeCode := generateStoreCode(8)

	logrus.Infof("📥 받은 값: %+v", req)
	logrus.Infof("🧱 MongoClient: %+v", s.MongoClient)

	newStore := model.Store{
		ID:        primitive.NewObjectID(),
		Name:      req.Name,
		Location:  req.Location,
		StoreCode: storeCode,
	}

	result, err := collection.InsertOne(ctx, newStore)
	logrus.Infof("insert result: %+v", result)

	if err != nil {
		logrus.Errorf("❌ Insert 에러: %v", err)
		return nil, status.Errorf(codes.Internal, "insert error: %v", err)
	}

	return &pb.StoreResponse{
		Store: &pb.Store{
			Id:        newStore.ID.Hex(),
			Name:      newStore.Name,
			Location:  newStore.Location,
			StoreCode: storeCode,
		},
	}, nil
}

func (c *StoreHandler) GetStoreById(ctx context.Context, req *pb.StoreIdRequest) (*pb.StoreResponse, error) {
	objID, err := primitive.ObjectIDFromHex(req.Id)
	if err != nil {
		return nil, status.Errorf(codes.InvalidArgument, "invalid ID format: %v", err)
	}

	var store model.Store
	err = mongodb.StoreColl.FindOne(ctx, primitive.M{"_id": objID}).Decode(&store)
	if err != nil {
		return nil, status.Errorf(codes.NotFound, "store not found: %v", err)
	}

	return &pb.StoreResponse{
		Store: &pb.Store{
			Id:        store.ID.Hex(),
			Name:      store.Name,
			Location:  store.Location,
			StoreCode: store.StoreCode,
		},
	}, nil
}

func (c *StoreHandler) GetStoreByCode(ctx context.Context, req *pb.StoreCodeRequest) (*pb.StoreResponse, error) {
	code := req.StoreCode

	var store model.Store
	err := mongodb.StoreColl.FindOne(ctx, primitive.M{"store_code": code}).Decode(&store)
	if err != nil {
		return nil, status.Errorf(codes.NotFound, "store not found: %v", err)
	}

	return &pb.StoreResponse{
		Store: &pb.Store{
			Id:        store.ID.Hex(),
			Name:      store.Name,
			Location:  store.Location,
			StoreCode: store.StoreCode,
		},
	}, nil
}

func (c *StoreHandler) GetStoreList(_ *emptypb.Empty, stream pb.StoreService_GetStoreListServer) error {

	collection := mongodb.StoreColl
	cursor, err := collection.Find(context.TODO(), bson.M{})
	if err != nil {
		return status.Errorf(codes.Internal, "failed to fetch stores: %v", err)
	}

	defer cursor.Close(context.TODO())

	for cursor.Next(context.TODO()) {
		var store model.Store
		if err := cursor.Decode(&store); err != nil {
			return status.Errorf(codes.Internal, "decode error: %v", err)
		}

		if err := stream.Send(&pb.Store{
			Id:        store.ID.Hex(),
			Name:      store.Name,
			Location:  store.Location,
			StoreCode: store.StoreCode,
		}); err != nil {
			return status.Errorf(codes.Internal, "stream send error: %v", err)
		}

	}
	if err := cursor.Err(); err != nil {
		return status.Errorf(codes.Internal, "cursor error: %v", err)
	}

	return nil
}

func (c *StoreHandler) UpdateStore(ctx context.Context, req *pb.UpdateStoreRequest) (*pb.StoreResponse, error) {
	objID, err := primitive.ObjectIDFromHex(req.Id)
	if err != nil {
		return nil, status.Errorf(codes.InvalidArgument, "invalid store ID: %v", err)
	}

	update := bson.M{
		"$set": bson.M{
			"name":     req.Name,
			"location": req.Location,
		},
	}

	result := mongodb.StoreColl.FindOneAndUpdate(ctx,
		bson.M{"_id": objID},
		update,
		options.FindOneAndUpdate().SetReturnDocument(options.After),
	)

	var updated model.Store
	err = result.Decode(&updated)
	if err != nil {
		return nil, status.Errorf(codes.NotFound, "store not found: %v", err)
	}

	return &pb.StoreResponse{
		Store: &pb.Store{
			Id:        updated.ID.Hex(),
			Name:      updated.Name,
			Location:  updated.Location,
			StoreCode: updated.StoreCode,
		},
	}, nil
}

func (c *StoreHandler) DeleteStore(ctx context.Context, req *pb.DeleteStoreRequest) (*emptypb.Empty, error) {
	objID, err := primitive.ObjectIDFromHex(req.Id)
	if err != nil {
		return nil, status.Errorf(codes.InvalidArgument, "invalid store ID: %v", err)
	}

	result, err := mongodb.StoreColl.DeleteOne(ctx, bson.M{"_id": objID})
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to delete store: %v", err)
	}

	if result.DeletedCount == 0 {
		return nil, status.Errorf(codes.NotFound, "store not found")
	}

	return &emptypb.Empty{}, nil
}
