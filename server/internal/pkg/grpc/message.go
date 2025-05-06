package grpcHandler

import (
	"context"
	"errors"
	"fmt"
	pb "server/gen"
	mmessage "server/internal/pkg/database/mongodb/message"
	mstore "server/internal/pkg/database/mongodb/store"
	dbstructure "server/internal/pkg/database/structure"
	"server/internal/pkg/utils"

	"go.mongodb.org/mongo-driver/mongo"

	"github.com/sirupsen/logrus"
	"google.golang.org/protobuf/types/known/timestamppb"
)

func (s *Server) GetMessages(
	ctx context.Context, req *pb.GetMessagesRequest,
) (response *pb.GetMessagesResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetMessages : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			response = &pb.GetMessagesResponse{
				Success: false,
				Error:   pbErr.Enum(),
			}
		}
	}()

	// store code -> store ID 로 변환 및 검증
	storeId, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	_, err = mmessage.GetNotificationMessage(&storeId, req.NotificationTitle, int(req.Number))
	if err != nil && errors.Is(err, mongo.ErrNoDocuments) {
		panic(pb.EError_EE_NOTIFICATION_NOT_FOUND)
	}

	messageTitle := fmt.Sprintf("%sMessage", req.NotificationTitle)
	// 메시지 조회
	mMessages, err := mmessage.GetMMessage(&storeId, req.Number, messageTitle)
	if err != nil {
		panic(err)
	}

	// notification accepted 변경
	err = mmessage.UpdateMNotificationAccepted(&storeId, req.NotificationTitle, req.Number, true)
	if err != nil {
		panic(err)
	}

	// 메세지 MMessage -> pb.Message 로 변환
	pbMessages := make([]*pb.Message, len(mMessages))
	for i, mMessage := range mMessages {
		pbMessages[i] = &pb.Message{
			Message:   mMessage.Message,
			IsOwner:   mMessage.IsOwner,
			CreatedAt: timestamppb.New(mMessage.CreatedAt),
		}
	}

	return &pb.GetMessagesResponse{
		Success:  true,
		Error:    nil,
		Title:    &mMessages[0].Title,
		Number:   &req.Number,
		Messages: pbMessages,
	}, nil
}

func (s *Server) GetChatRoomList(
	ctx context.Context, req *pb.GetChatRoomListRequest,
) (response *pb.GetChatRoomListResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetChatRoomList : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			response = &pb.GetChatRoomListResponse{
				Success: false,
				Error:   pbErr.Enum(),
			}
		}
	}()

	// store code -> store ID 로 변환 및 검증
	storeId, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		logrus.Errorf("Store validation failed: %v", err)
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	var mNotificationMessages []dbstructure.MNotificationMessage
	if req.ChatRoomStatus == pb.ChatRoomStatus_CHATROOM_STATUS_COMPLETE {
		mNotificationMessages, err = mmessage.GetFinishedMNotificationMessageList(&storeId)
		if err != nil {
			logrus.Errorf("Failed to get finished messages: %v", err)
			panic(err)
		}
	}

	if req.ChatRoomStatus == pb.ChatRoomStatus_CHATROOM_STATUS_BEFORE {
		mNotificationMessages, err = mmessage.GetNotFinishedMNotificationMessageList(&storeId)
		if err != nil {
			logrus.Errorf("Failed to get unfinished messages: %v", err)
			panic(err)
		}
	}

	logrus.Infof("Found %d notification messages", len(mNotificationMessages))

	pbChatRoomInfos := make([]*pb.ChatRoomInfo, len(mNotificationMessages))
	for i, mNotificationMessage := range mNotificationMessages {
		pbChatRoomInfos[i] = &pb.ChatRoomInfo{
			NotificationTitle: mNotificationMessage.NotificationTitle,
			Number:            int32(mNotificationMessage.Number),
		}
	}

	return &pb.GetChatRoomListResponse{
		Success:       true,
		Error:         nil,
		ChatRoomInfos: pbChatRoomInfos,
	}, nil
}
