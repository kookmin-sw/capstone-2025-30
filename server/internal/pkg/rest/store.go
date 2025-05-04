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
	"server/internal/pkg/utils"
)

func (h *RestHandler) CreateStore(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST CreateStore] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	type CreateStoreBody struct {
		Name     string `json:"name" binding:"required"`
		Location string `json:"location" binding:"required"`
	}

	var req CreateStoreBody
	if err := c.ShouldBindJSON(&req); err != nil {
		logrus.Errorf("[REST CreateStore] Failed to JSON Binding: %v", err)
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

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
		logrus.Errorf("[REST CreateStore] Failed to Call CreateStore grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST CreateStore] Failed by CreateStore grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"error":   nil,
		"store":   grpcRes.GetStore(),
	})
}

func (h *RestHandler) GetStoreList(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST GetStoreList] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.GetStoreList(ctx, &emptypb.Empty{})
	if err != nil {
		logrus.Errorf("[REST GetStoreList] Failed to Call GetStoreList grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST GetStoreList] Failed by GetStoreList grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"error":   nil,
		"store":   grpcRes.GetStores(),
	})
}

func (h *RestHandler) GetStore(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST GetStore] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	storeCode := c.Param("store_code")

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.GetStoreRequest{StoreCode: storeCode}

	grpcRes, err := authClient.GetStore(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("[REST GetStore] Failed to Call GetStore grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST GetStore] Failed by GetStore grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"error":   nil,
		"store":   grpcRes.GetStore(),
	})
}

func (h *RestHandler) UpdateStore(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST UpdateStore] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	storeCode := c.Param("store_code")

	var req pb.UpdateStoreRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		logrus.Errorf("[REST UpdateStore] Failed to bind JSON: %v", err)
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	if req.Name == "" && req.Location == "" {
		logrus.Error("[REST UpdateStore] StoreCode or Location is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	req.StoreCode = storeCode

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.UpdateStore(ctx, &req)
	if err != nil {
		logrus.Errorf("[REST UpdateStore] Failed to Call UpdateStore: %v", err)
		panic(err)
	}
	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST UpdateStore] Failed by UpdateStore grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"error":   nil,
		"store":   grpcRes.GetStore(),
	})
}

func (h *RestHandler) DeleteStore(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST DeleteStore] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	storeCode := c.Param("store_code")
	if storeCode == "" {
		logrus.Error("[REST DeleteStore] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.DeleteStoreRequest{StoreCode: storeCode}

	grpcRes, err := authClient.DeleteStore(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("[REST DeleteStore] Failed to Call DeleteStore grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST DeleteStore] Failed by DeleteStore grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"error":   nil,
	})
}
