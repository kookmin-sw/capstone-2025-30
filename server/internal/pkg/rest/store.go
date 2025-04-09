package rest

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/metadata"
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
	})
}
