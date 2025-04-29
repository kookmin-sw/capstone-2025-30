package rest

import (
	"context"
	"net/http"
	"os"
	pb "server/gen"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/metadata"
)

func (h *RestHandler) GetMessages(c *gin.Context) {
	storeCode := c.Param("store_code")

	var req pb.GetMessagesRequest
	if !BindJSONOrError(c, &req) {
		return
	}

	req.StoreCode = storeCode

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetMessages rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.GetMessages(ctx, &req)
	if err != nil {
		logrus.Errorf("GetMessages failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	restMessages := make([]RestMessage, len(grpcRes.Messages))
	for i, msg := range grpcRes.Messages {
		restMessages[i] = convertToRestMessage(msg)
	}

	c.JSON(http.StatusOK, gin.H{
		"success":  grpcRes.GetSuccess(),
		"error":    grpcRes.GetError(),
		"messages": restMessages,
		"title":    grpcRes.GetTitle(),
		"number":   grpcRes.GetNumber(),
	})
}

type RestMessage struct {
	Message   string `json:"message"`
	IsOwner   bool   `json:"is_owner"`
	CreatedAt string `json:"created_at"`
}

func convertToRestMessage(grpcMessage *pb.Message) RestMessage {
	return RestMessage{
		Message:   grpcMessage.Message,
		IsOwner:   grpcMessage.IsOwner,
		CreatedAt: grpcMessage.CreatedAt.AsTime().Format(time.RFC3339),
	}
}
