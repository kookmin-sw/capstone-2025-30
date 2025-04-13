package grpcHandler

import (
	"encoding/json"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	pb "server/gen"
	mstore "server/internal/pkg/database/mongodb/store"
	"server/internal/pkg/utils"
	"sync"
	"time"
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
				TotalReceived: 0,
				Success:       false,
				Error:         pbErr.Enum(),
			})
		}
	}()

	var (
		sequence       []float32
		totalReceived  int32 = 0
		storeObjectID  *string
		once           sync.Once
		timeoutSeconds = 10 * time.Second
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
				str := objectID.Hex()
				storeObjectID = &str
			})

			logrus.Infof("StreamInquiries received: store_code=%s, type=%s, data=%s", req.StoreCode, req.InquiryType, req.FrameData)

			var frame []float32

			if err := json.Unmarshal([]byte(req.FrameData), &frame); err != nil {
				logrus.Warn("error unmarshalling frame data: ", err)
				continue
			}

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
	predictResp, err := s.AiClient.Predict(stream.Context(), &pb.SequenceInput{
		Values:   sequence,
		ClientId: *storeObjectID,
	})
	if err != nil {
		logrus.Error("error calling AI client: ", err)
		panic(stream.SendAndClose(&pb.InquiryResponse{
			TotalReceived: totalReceived,
			Success:       false,
			Error:         pb.EError_EE_INQUIRY_STREAM_FAILED.Enum(),
		}))
	}

	// 응답 받아서 클라이언트로 전송
	return stream.SendAndClose(&pb.InquiryResponse{
		TotalReceived:    totalReceived,
		Success:          true,
		Error:            nil,
		TranslatedKorean: predictResp.PredictedWord,
	})
}
