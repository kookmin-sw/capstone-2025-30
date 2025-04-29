package grpcHandler

import (
	"context"
	"fmt"
	pb "server/gen"
	mmessage "server/internal/pkg/database/mongodb/message"
	mstore "server/internal/pkg/database/mongodb/store"
	"server/internal/pkg/utils"

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

	messageTitle := fmt.Sprintf("%sMessage", req.NotificationTitle)
	// 메시지 조회
	mMessages, err := mmessage.GetMMessage(&storeId, req.Number, messageTitle)
	if err != nil {
		panic(fmt.Errorf("failed to get messages: %v", err))
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
		Title:    mMessages[0].Title,
		Number:   req.Number,
		Messages: pbMessages,
	}, nil
}
