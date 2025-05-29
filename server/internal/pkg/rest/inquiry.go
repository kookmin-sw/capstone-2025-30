package rest

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/metadata"
	"net/http"
	"os"
	pb "server/gen"
	"server/internal/pkg/utils"
	"strconv"
)

func (h *RestHandler) UpdateInquiryStatus(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST UpdateInquiryStatus] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	storeCode := c.Param("store_code")
	if storeCode == "" {
		logrus.Error("[REST UpdateInquiryStatus] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	inquiryNumberStr := c.Param("inquiry_number")
	if inquiryNumberStr == "" {
		logrus.Error("[REST UpdateInquiryStatus] Inquiry Number is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	inquiryNumber, err := strconv.Atoi(inquiryNumberStr)
	if err != nil {
		logrus.Error("[REST UpdateInquiryStatus] Inquiry Number is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	var req struct {
		Status string `json:"status"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		logrus.Error("[REST UpdateInquiryStatus] Invalid Inquiry Status")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	status, ok := pb.InquiryStatus_value[req.Status]
	if !ok {
		logrus.Errorf("REST UpdateInquiryStatus] Invalid Inquiry Status")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.UpdateInquiryStatusRequest{
		StoreCode:     storeCode,
		InquiryNumber: int32(inquiryNumber),
		Status:        pb.InquiryStatus(status),
	}

	grpcRes, err := authClient.UpdateInquiryStatus(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("[REST UpdateInquiryStatus] Failed to Call UpdateInquiryStatus grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST UpdateInquiryStatus] Failed by UpdateInquiryStatus grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"error":   nil,
		"status":  grpcRes.GetStatus().String(),
	})
}
