package grpcHandler

import (
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	pb "server/gen"
	"server/internal/pkg/utils"
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

	// 인증 (storeId -> objectID 로 변환)

	var inquiryes []*pb.InquiryRequest
	var totalReceived int32 = 0

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

		logrus.Infof("StreamInquiries received: store_id=%s, type=%s, data=%s", req.StoreId, req.InquiryType, req.FrameData)

		inquiryes = append(inquiryes, req)
		totalReceived++
	}

	// 축적한 데이터 ai 로 전송

	// 응답 받아서 클라이언트로 전송
	time.Sleep(time.Second * 10) // 인공지능 서버에 요청하는 시간

	return stream.SendAndClose(&pb.InquiryResponse{
		TotalReceived: totalReceived,
		Success:       true,
		Error:         nil,
	})
}
