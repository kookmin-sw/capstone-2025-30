package grpcHandler

import (
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
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
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
			errRes = status.Errorf(codes.Internal, "internal server error")
			_ = stream.SendAndClose(&pb.InquiryResponse{
				Success: false,
				Error:   pbErr.Enum(),
			})
		}
	}()

	var (
		sequence       []float32
		totalReceived  int32 = 0
		storeCode      string
		storeObjectID  *primitive.ObjectID
		once           sync.Once
		timeoutSeconds = 1 * time.Second
		inquiryType    string
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
			fmt.Println("여기")
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

			logrus.Infof("StreamInquiries received: store_code=%s, type=%s, data=%s", req.StoreCode, req.InquiryType, req.FrameData)

			frame := req.FrameData

			//test info
			logrus.Infof("marshalled frame data: %v", frame)

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
	predictResp, err := s.AiClient.PredictFromFrames(stream.Context(), &pb.FrameSequenceInput{
		Frames:  sequence,
		StoreId: storeObjectID.Hex(),
		Fps:     30,
		//VideoLength: totalReceived,
		VideoLength: 740,
	})
	if err != nil {
		logrus.Error("error calling AI client: ", err)
		panic(stream.SendAndClose(&pb.InquiryResponse{
			Success: false,
			Error:   pb.EError_EE_INQUIRY_STREAM_FAILED.Enum(),
		}))
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
	err = mmessage.CreateMMessage(&mMessage)
	if err != nil {
		panic(fmt.Errorf("failed to create message: %v", err))
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
			if err := websocketHandler.SendMessageToClient(storeCode, message); err != nil {
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
