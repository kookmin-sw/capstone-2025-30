package rest

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/metadata"
	"google.golang.org/protobuf/types/known/emptypb"
	"net/http"
	"os"
	pb "server/gen"
)

func (h *RestHandler) CreateStore(c *gin.Context) {
	var req pb.CreateStoreRequest

	if !BindJSONOrError(c, &req) {
		return
	}

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in CreateStore rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.CreateStoreRequest{
		Name:     req.Name,
		Location: req.Location,
	}

	grpcRes, err := authClient.CreateStore(ctx, grpcReq)
	if err != nil {
		logrus.Error("CreateStore failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	//grpc func 호출
	//grpcRes, err := authClient.
	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
		"store":   grpcRes.GetStore(),
	})
}

func (h *RestHandler) GetStoreList(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetStoreList rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.GetStoreList(ctx, &emptypb.Empty{})
	if err != nil {
		logrus.Errorf("GetStoreList failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
		"stores":  grpcRes.GetStores(), // []*ViewStore 그대로 반환
	})
}

func (h *RestHandler) GetStore(c *gin.Context) {
	storeCode := c.Param("store_code")

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetStore rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.GetStoreRequest{StoreCode: storeCode}

	grpcRes, err := authClient.GetStore(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("GetStore failed: %v", err)
		c.JSON(http.StatusNotFound, gin.H{"error": "store not found"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
		"store":   grpcRes.GetStore(),
	})
}

func (h *RestHandler) UpdateStore(c *gin.Context) {
	storeCode := c.Param("store_code")

	var req pb.UpdateStoreRequest
	if !BindJSONOrError(c, &req) {
		return
	}
	req.StoreCode = storeCode

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in UpdateStore rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.UpdateStore(ctx, &req)
	if err != nil {
		logrus.Errorf("UpdateStore failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
		"store":   grpcRes.GetStore(),
	})
}

func (h *RestHandler) DeleteStore(c *gin.Context) {
	storeCode := c.Param("store_code")

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in DeleteStore rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.DeleteStoreRequest{StoreCode: storeCode}
	grpcRes, err := authClient.DeleteStore(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("DeleteStore failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
	})
}
