package rest

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/metadata"
	"net/http"
	"os"
	pb "server/gen"
	"strconv"
)

func (h *RestHandler) CreateOrder(c *gin.Context) {
	storeCode := c.Param("store_code")

	var req pb.CreateOrderRequest
	if !BindJSONOrError(c, &req) {
		return
	}

	req.StoreCode = storeCode

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in CreateOrder rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.CreateOrder(ctx, &req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success":      grpcRes.GetSuccess(),
		"error":        grpcRes.GetError(),
		"order_number": grpcRes.GetOrderNumber(),
	})
}

func (h *RestHandler) GetOrderStatus(c *gin.Context) {
	storeCode := c.Param("store_code")
	orderNumberStr := c.Param("order_number")

	orderNumber, err := strconv.Atoi(orderNumberStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid order number"})
		return
	}

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetOrderStatus rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.GetOrderStatusRequest{
		StoreCode:   storeCode,
		OrderNumber: int32(orderNumber),
	}

	grpcRes, err := authClient.GetOrderStatus(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("GetOrderStatus failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success":     grpcRes.GetSuccess(),
		"error":       grpcRes.GetError(),
		"status":      grpcRes.GetStatus().String(),
		"dine_in":     grpcRes.GetDineIn(),
		"items":       grpcRes.GetItems(),
		"total_price": grpcRes.GetTotalPrice(),
	})
}

func (h *RestHandler) GetOrderList(c *gin.Context) {
	storeCode := c.Param("store_code")

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetOrderList rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.GetOrderList(ctx, &pb.GetOrderListRequest{
		StoreCode: storeCode,
	})
	if err != nil {
		logrus.Errorf("GetOrderList failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
		"orders":  grpcRes.GetOrders(),
	})
}

func (h *RestHandler) UpdateOrderStatus(c *gin.Context) {
	storeCode := c.Param("store_code")
	orderNumberStr := c.Param("order_number")

	orderNumber, err := strconv.Atoi(orderNumberStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid order number"})
		return
	}

	var req struct {
		Status string `json:"status"` // enum string으로 받음
	}
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
		return
	}

	// 문자열로 받은 status → gRPC enum으로 변환
	status, ok := pb.OrderStatus_value[req.Status]
	if !ok {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid order status"})
		return
	}

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in UpdateOrderStatus rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.UpdateOrderStatusRequest{
		StoreCode:   storeCode,
		OrderNumber: int32(orderNumber),
		Status:      pb.OrderStatus(status),
	}

	grpcRes, err := authClient.UpdateOrderStatus(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("UpdateOrderStatus failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
		"status":  grpcRes.GetStatus().String(),
	})
}
