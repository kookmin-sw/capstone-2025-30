package grpcHandler

import (
	"encoding/json"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	pb "server/gen"
	mauth "server/internal/pkg/database/mongodb/auth"
	"server/internal/pkg/utils"
	"sync"
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

	var sequence []float32
	var totalReceived int32 = 0
	var storeObjectID *string
	var once sync.Once

	// 데이터 스트리밍으로 받아서 축적하기
	for {
		req, err := stream.Recv()
		if err != nil {
			if err.Error() == "EOF" {
				break
			}
			logrus.Error("error receiving stream: ", err)
			panic(pb.EError_EE_INQUIRY_STREAM_FAILED)
		}

		once.Do(func() {
			storeObjectID, err = mauth.GetObjectIdInStore(req.StoreCode)
			if err != nil {
				logrus.Error("failed to get store object ID: ", err)
				panic(pb.EError_EE_API_FAILED)
			}
		})

		logrus.Infof("StreamInquiries received: store_code=%s, type=%s, data=%s", req.StoreCode, req.InquiryType, req.FrameData)

		var frame struct {
			People struct {
				PoseKeyPoints2D []float32 `json:"pose_keypoints_2d"`
			} `json:"people"`
		}

		if err := json.Unmarshal([]byte(req.FrameData), &frame); err != nil {
			logrus.Warn("error unmarshalling frame data: ", err)
			continue
		}

		sequence = append(sequence, frame.People.PoseKeyPoints2D...)
		totalReceived++
	}

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
