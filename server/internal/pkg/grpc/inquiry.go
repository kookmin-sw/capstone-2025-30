package grpcHandler

import (
	"context"
	"fmt"
	pb "server/gen"
	mmessage "server/internal/pkg/database/mongodb/message"
	mstore "server/internal/pkg/database/mongodb/store"
	dbstructure "server/internal/pkg/database/structure"
	"server/internal/pkg/utils"
	websocketHandler "server/internal/pkg/websocket"
	"sync"
	"time"

	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (s *Server) StreamInquiries(
	stream pb.APIService_StreamInquiriesServer,
) (
	errRes error,
) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in StreamInquiries : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			_ = stream.SendAndClose(&pb.InquiryResponse{
				Success: false,
				Error:   pbErr.Enum(),
			})
			errRes = nil
		}
	}()

	var (
		sequence       []float32
		totalReceived  int32 = 0
		storeCode      string
		storeObjectID  *primitive.ObjectID
		once           sync.Once
		timeoutSeconds = 5 * time.Second
		inquiryType    string
		inquiryNum     *int32
		num            int32
	)

	recvChan := make(chan *pb.InquiryRequest)
	errChan := make(chan error)

	// 데이터 스트리밍으로 받아서 축적하기
	go func() {
		for {
			req, err := stream.Recv()
			if err != nil {
				errChan <- err
				return
			}
			recvChan <- req
		}
	}()

	timer := time.NewTimer(timeoutSeconds)

loop:
	for {
		select {
		case req := <-recvChan:
			if !timer.Stop() {
				<-timer.C
			}
			timer.Reset(timeoutSeconds)
			once.Do(func() {
				var err error
				objectID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
				if err != nil {
					panic(pb.EError_EE_STORE_NOT_FOUND)
				}
				storeObjectID = &objectID

				// 1번만
				inquiryType = req.InquiryType
				num = req.Num
				storeCode = req.StoreCode
			})

			//logrus.Infof("StreamInquiries received: store_code=%s, type=%s, data=%s", req.StoreCode, req.InquiryType, req.FrameData)

			frame := req.FrameData

			//test info
			//logrus.Infof("marshalled frame data: %v", frame)

			sequence = append(sequence, frame...)
			totalReceived++
		case err := <-errChan:
			if err.Error() == "EOF" {
				logrus.Info("client finished sending stream(EOF)")
			} else {
				logrus.Error("error receiving stream: ", err)
			}
			break loop
		case <-timer.C:
			logrus.Info("no data received for %v seconds, timing out stream", timeoutSeconds)
			break loop
		}
	}

	// test info
	logrus.Infof("total received: %d", totalReceived)

	// 축적한 데이터 ai 로 전송
	predictResp, err := utils.AiClient.PredictFromFrames(stream.Context(), &pb.FrameSequenceInput{
		Frames:      sequence,
		StoreId:     storeObjectID.Hex(),
		Fps:         30,
		VideoLength: totalReceived,
	})
	if err != nil {
		logrus.Error("error calling AI client: ", err)
		panic(pb.EError_EE_INQUIRY_STREAM_FAILED)
	}

	logrus.Infof("confidence : ", predictResp.Confidence)
	if predictResp.Confidence <= 0.5 {
		panic(pb.EError_EE_AI_CONVERSION_CONFIDENCE_IS_WRONG)
	}

	// message 구조체 생성
	createTime := time.Now()
	messageType := ""
	if inquiryType == utils.StreamDataTypeOrder {
		messageType = utils.WebSocketMessageTypeOrder
	}
	if inquiryType == utils.StreamDataTypeInquiry {
		messageType = utils.WebSocketMessageTypeInquiry
	}

	mMessage := dbstructure.MMessage{
		ID:        primitive.NewObjectID(),
		StoreId:   *storeObjectID,
		Title:     messageType,
		Number:    num,
		CreatedAt: createTime,
		Message:   predictResp.PredictedSentence,
		IsOwner:   false,
	}

	mNotification := dbstructure.MNotificationMessage{
		ID:                primitive.NewObjectID(),
		StoreCode:         *storeObjectID,
		NotificationTitle: inquiryType,
		CreatedAt:         createTime,
		UpdatedAt:         createTime,
		Accepted:          true,
		Finished:          false,
		Deleted:           false,
	}

	logrus.Infof("received inquiry_type: %s", inquiryType)
	if inquiryType == utils.StreamDataTypeOrder {
		err = mmessage.CreateMMessage(&mMessage)
		if err != nil {
			panic(fmt.Errorf("failed to create message: %v", err))
		}
	}
	if inquiryType == utils.StreamDataTypeInquiry {
		inquiryNum, err = mmessage.CreateMMessageAndNotification(&mMessage, &mNotification, storeCode)
		num = *inquiryNum
		if err != nil {
			panic(fmt.Errorf("failed to create message & notification: %v", err))
		}
	}

	// 웹소켓으로 메세지 전송 & 전송한 메세지 저장
	go func() {
		maxRetries := 3
		backoff := time.Second

		message := websocketHandler.WebSocketMessage{
			Type: messageType,
			Data: websocketHandler.MessageData{
				Num:       num,
				Message:   predictResp.PredictedSentence,
				CreatedAt: createTime,
			},
		}

		for attempt := 1; attempt <= maxRetries; attempt++ {
			if err := websocketHandler.SendMessageToClient(storeCode, message, utils.WebSocketClientTypeManagerWeb); err != nil {
				logrus.Warnf("Websocket send attempt %d failed: %v", attempt, err)

				if attempt == maxRetries {
					logrus.Errorf("Failed to send websocket notification after %d attempts: %v", maxRetries, err)
					return // 모든 시도 실패 후 종료
				}

				time.Sleep(backoff)
				backoff *= 2
			} else {
				return
			}
		}
	}()

	// 응답 받아서 클라이언트로 전송
	return stream.SendAndClose(&pb.InquiryResponse{
		Success: true,
		Error:   nil,
	})
}

func (s *Server) FastInquiryRespIsNo(
	ctx context.Context, req *pb.FastInquiryRespIsNoRequest,
) (
	res *pb.FastInquiryRespIsNoResponse, errRes error,
) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in FastInquiryRespIsNo : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			res = &pb.FastInquiryRespIsNoResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	// store_code 검증
	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		logrus.Errorf("[gRPC FastInquiryRespIsNo] Store Id is not founded by store code(%s): %v", req.StoreCode, err)
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	// notification(채팅방, 대화창, 알림) 이 있는지 검증
	_, err = mmessage.GetNotificationMessage(&storeID, req.Title, int(req.Num))
	if err != nil {
		logrus.Errorf("[gRPC FastInquiryRespIsNo] Notification is not founded by store code(%s), title(%s), num(%d): %v", req.StoreCode, req.Title, req.Num, err)
		panic(pb.EError_EE_NOTIFICATION_NOT_FOUND)
	}

	// 아니요 메세지 저장
	title := ""
	if req.Title == utils.NotificationTitleOrder {
		title = utils.WebSocketMessageTypeOrder
	} else if req.Title == utils.NotificationTitleInquiry {
		title = utils.WebSocketMessageTypeInquiry
	}

	createTime := time.Now()
	mMessage := dbstructure.MMessage{
		ID:        primitive.NewObjectID(),
		StoreId:   storeID,
		Title:     title,
		CreatedAt: createTime,
		Message:   "아니요.",
		IsOwner:   false,
		Number:    req.Num,
	}

	err = mmessage.CreateMMessage(&mMessage)
	if err != nil {
		panic(pb.EError_EE_MESSAGE_CREATE_FAILED)
	}
	// 아니요 메세지 관리자 웹에 전송
	go func() {
		maxRetries := 3
		backoff := time.Second // 초기 대기 시간 1초

		message := websocketHandler.WebSocketMessage{
			Type: title,
			Data: websocketHandler.MessageData{
				Num:       req.Num,
				Message:   "아니요.",
				CreatedAt: createTime,
			},
		}

		for attempt := 1; attempt <= maxRetries; attempt++ {
			if err := websocketHandler.SendMessageToClient(req.StoreCode, message, utils.WebSocketClientTypeManagerWeb); err != nil {
				logrus.Warnf("Websocket send attempt %d failed: %v", attempt, err)

				if attempt == maxRetries {
					logrus.Errorf("Failed to send websocket notification after %d attempts: %v", maxRetries, err)
					return // 모든 시도 실패 후 종료
				}

				time.Sleep(backoff)
				backoff *= 2
			} else {
				return
			}
		}
	}()

	// 응답 반환
	return &pb.FastInquiryRespIsNoResponse{Success: true, Error: nil}, nil
}

func (s *Server) UpdateInquiryStatus(ctx context.Context, req *pb.UpdateInquiryStatusRequest) (res *pb.UpdateInquiryStatusResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[gRPC UpdateInquiryStatus] panic: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			res = &pb.UpdateInquiryStatusResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		logrus.Errorf("[gRPC UpdateInquiryStatus] Store Id is not founded by store code(%s): %v", req.StoreCode, err)
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mNotification, err := mmessage.GetNotificationMessage(&storeID, "inquiry", int(req.InquiryNumber))
	if err != nil {
		logrus.Errorf("[gRPC UpdateInquiryStatus] Failed to get notification")
		panic(err)
	}
	if mNotification == nil {
		logrus.Errorf("[gRPC UpdateInquiryStatus] Notification is not founded")
		panic(pb.EError_EE_NOTIFICATION_NOT_FOUND)
	}

	err = mmessage.UpdateMNotificationFinished(&storeID, "inquiry", req.InquiryNumber, true)
	if err != nil {
		logrus.Errorf("[gRPC UpdateInquiryStatus] UpdateMNotificationFinished error")
		panic(err)
	}

	return &pb.UpdateInquiryStatusResponse{
		Success: true,
		Error:   nil,
		Status:  req.Status,
	}, nil
}
