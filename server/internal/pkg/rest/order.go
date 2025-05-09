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

func (h *RestHandler) CreateOrder(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST CreateOrder] panic: ", r)
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
		logrus.Error("[REST CreateOrder] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	type CreateOrderBody struct {
		DineIn     *bool           `json:"dine_in" binding:"required"`
		Items      []*pb.OrderItem `json:"items" binding:"required"`
		TotalPrice int32           `json:"total_price" binding:"required"`
	}

	var req CreateOrderBody
	if err := c.ShouldBindJSON(&req); err != nil {
		logrus.Errorf("[REST CreateOrder] Failed to JSON Binding: %v", err)
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	for _, item := range req.Items {
		if item.Name == "" || item.Quantity <= 0 || item.ItemPrice <= 0 {
			logrus.Warnf("[REST CreateOrder] Invalid item: %+v", item)
			panic(pb.EError_EE_INVALID_ARGUMENT)
		}
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.CreateOrderRequest{
		StoreCode:  storeCode,
		DineIn:     *req.DineIn,
		Items:      req.Items,
		TotalPrice: req.TotalPrice,
	}

	grpcRes, err := authClient.CreateOrder(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("[REST CreateOrder] Failed to Call CreateOrder grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST CreateOrder] Failed by CreateOrder grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success":      true,
		"error":        nil,
		"order_number": grpcRes.GetOrderNumber(),
	})
}

func (h *RestHandler) GetOrderStatus(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST GetOrderStatus] panic: ", r)
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
		logrus.Error("[REST GetOrderStatus] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	orderNumberStr := c.Param("order_number")
	if orderNumberStr == "" {
		logrus.Error("[REST GetOrderStatus] Order Number is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	orderNumber, err := strconv.Atoi(orderNumberStr)
	if err != nil {
		logrus.Error("[REST GetOrderStatus] Order Number is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.GetOrderStatusRequest{
		StoreCode:   storeCode,
		OrderNumber: int32(orderNumber),
	}

	grpcRes, err := authClient.GetOrderStatus(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("[REST GetOrderStatus] Failed to Call GetOrderStatus grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST GetOrderStatus] Failed by GetOrderStatus grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success":     true,
		"error":       nil,
		"status":      grpcRes.GetStatus().String(),
		"dine_in":     grpcRes.GetDineIn(),
		"items":       grpcRes.GetItems(),
		"total_price": grpcRes.GetTotalPrice(),
	})
}

func (h *RestHandler) GetOrderList(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST GetOrderList] panic: ", r)
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
		logrus.Error("[REST GetOrderList] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.GetOrderList(ctx, &pb.GetOrderListRequest{
		StoreCode: storeCode,
	})

	if err != nil {
		logrus.Errorf("[REST GetOrderList] Failed to Call GetOrderList grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST GetOrderList] Failed by GetOrderList grpc: %v", grpcRes.GetError())
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
		"orders":  grpcRes.GetOrders(),
	})
}

func (h *RestHandler) UpdateOrderStatus(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST UpdateOrderStatus] panic: ", r)
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
		logrus.Error("[REST UpdateOrderStatus] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	orderNumberStr := c.Param("order_number")
	if orderNumberStr == "" {
		logrus.Error("[REST UpdateOrderStatus] Order Number is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	orderNumber, err := strconv.Atoi(orderNumberStr)
	if err != nil {
		logrus.Error("[REST UpdateOrderStatus] Order Number is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	var req struct {
		Status string `json:"status"` // enum string 으로 받음
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		logrus.Error("[REST UpdateOrderStatus] Invalid Order Status")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	// 문자열로 받은 status → gRPC enum으로 변환
	status, ok := pb.OrderStatus_value[req.Status]
	if !ok {
		logrus.Errorf("REST UpdateOrderStatus] Invalid Order Status")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.UpdateOrderStatusRequest{
		StoreCode:   storeCode,
		OrderNumber: int32(orderNumber),
		Status:      pb.OrderStatus(status),
	}

	grpcRes, err := authClient.UpdateOrderStatus(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("[REST UpdateOrderStatus] Failed to Call UpdateOrderStatus grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST UpdateOrderStatus] Failed by UpdateOrderStatus grpc: %v", grpcRes.GetError())
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
