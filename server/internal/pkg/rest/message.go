package rest

import (
	"context"
	"net/http"
	"os"
	pb "server/gen"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/metadata"
)

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

type RestChatRoomInfo struct {
	NotificationTitle string `json:"notification_title"`
	Number            int32  `json:"number"`
}

func convertToRestChatRoomInfo(grpcChatRoomInfo *pb.ChatRoomInfo) RestChatRoomInfo {
	return RestChatRoomInfo{
		NotificationTitle: grpcChatRoomInfo.NotificationTitle,
		Number:            grpcChatRoomInfo.Number,
	}
}

func (h *RestHandler) GetMessages(c *gin.Context) {
	storeCode := c.Param("store_code")
	notificationTitle := c.Query("notification_title")
	number := c.Query("number")

	numberInt, err := strconv.ParseInt(number, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid number format"})
		return
	}

	var req pb.GetMessagesRequest

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

	grpcReq := &pb.GetMessagesRequest{
		StoreCode:         storeCode,
		NotificationTitle: notificationTitle,
		Number:            int32(numberInt),
	}

	grpcRes, err := authClient.GetMessages(ctx, grpcReq)
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

func (h *RestHandler) GetMessageList(c *gin.Context) {
	storeCode := c.Param("store_code")
	chatRoomStatus := c.Query("chat_room_status")

	// 문자열을 enum으로 변환
	status, ok := pb.ChatRoomStatus_value[chatRoomStatus]
	if !ok {
		logrus.Errorf("Invalid chat room status: %s", chatRoomStatus)
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid chat room status"})
		return
	}

	grpcReq := &pb.GetChatRoomListRequest{
		StoreCode:      storeCode,
		ChatRoomStatus: pb.ChatRoomStatus(status),
	}

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

	grpcRes, err := authClient.GetChatRoomList(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("GetMessages failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	restChatRoomInfos := make([]RestChatRoomInfo, len(grpcRes.ChatRoomInfos))
	for i, info := range grpcRes.ChatRoomInfos {
		restChatRoomInfos[i] = convertToRestChatRoomInfo(info)
	}

	c.JSON(http.StatusOK, gin.H{
		"success":        grpcRes.GetSuccess(),
		"error":          grpcRes.GetError(),
		"chat_room_info": restChatRoomInfos,
	})
}
