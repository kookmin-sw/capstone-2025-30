package grpcHandler

import (
	"context"
	"fmt"
	pb "server/gen"
	mmenu "server/internal/pkg/database/mongodb/menu"
	morder "server/internal/pkg/database/mongodb/order"
	mstore "server/internal/pkg/database/mongodb/store"
	dbstructure "server/internal/pkg/database/structure"
	"server/internal/pkg/utils"
	"strings"
	"time"

	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (s *Server) CreateOrder(ctx context.Context, req *pb.CreateOrderRequest) (res *pb.CreateOrderResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in CreateOrder grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			res = &pb.CreateOrderResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	// 주문 아이템 변환
	var items []dbstructure.MOrderItem
	for _, item := range req.Items {

		image, err := mmenu.FindMenuImage(storeID, item.Name)
		if err != nil {
			logrus.Warnf("Image not found for %s: %v", item.Name, err)
			image = ""
		}

		items = append(items, dbstructure.MOrderItem{
			Name:      item.Name,
			Image:     image,
			Options:   item.Options.Choices,
			Quantity:  item.Quantity,
			ItemPrice: item.ItemPrice,
		})
	}

	// 주문 구조체 생성
	createTime := time.Now()
	mOrder := dbstructure.MOrder{
		ID:         primitive.NewObjectID(),
		StoreID:    storeID,
		StoreCode:  req.StoreCode,
		DineIn:     req.DineIn,
		Status:     pb.OrderStatus_ORDER_PENDING,
		Items:      items,
		TotalPrice: req.TotalPrice,
		CreatedAt:  createTime,
		UpdatedAt:  createTime,
	}

	// 알림 DB에 저장
	mNotificationMessage := dbstructure.MNotificationMessage{
		ID:                primitive.NewObjectID(),
		StoreCode:         storeID,
		NotificationTitle: utils.NotificationTitleOrder,
		Accepted:          false,
		Deleted:           false,
		CreatedAt:         createTime,
		UpdatedAt:         createTime,
	}

	//메세지 DB에 저장
	mMessage := dbstructure.MMessage{
		ID:        primitive.NewObjectID(),
		StoreId:   storeID,
		Title:     utils.WebSocketMessageTypeOrder,
		CreatedAt: createTime,
		Message:   itemsToString(&mOrder.Items),
		IsOwner:   true,
	}

	err = morder.CreateMOrderAndMNotificationMessageAndMMessageWithTransaction(&mOrder, &mNotificationMessage, &mMessage)
	if err != nil {
		panic(pb.EError_EE_ORDER_AND_NOTIFICATION_AND_MESSAGE_DB_ADD_FAILED)
	}

	// go func() {
	// 	maxRetries := 3
	// 	backoff := time.Second // 초기 대기 시간 1초
	// 	// 웹소켓 전송 시도
	// 	notification := websocketHandler.WebSocketMessage{
	// 		Type: utils.WebSocketMessageTypeNotification,
	// 		Data: websocketHandler.NotificationData{
	// 			Title: utils.NotificationTitleOrder,
	// 			Num:   mNotificationMessage.Number,
	// 		},
	// 	}

	// 	for attempt := 1; attempt <= maxRetries; attempt++ {
	// 		if err := websocketHandler.SendMessageToClient(req.StoreCode, notification); err != nil {
	// 			logrus.Warnf("Websocket send attempt %d failed: %v", attempt, err)

	// 			if attempt == maxRetries {
	// 				logrus.Errorf("Failed to send websocket notification after %d attempts: %v", maxRetries, err)
	// 				return // 모든 시도 실패 후 종료
	// 			}

	// 			// 다음 시도 전 대기
	// 			time.Sleep(backoff)
	// 			backoff *= 2 // 지수 백오프
	// 		} else {
	// 			return // 성공 시 종료
	// 		}
	// 	}
	// }()

	return &pb.CreateOrderResponse{
		Success:     true,
		Error:       nil,
		OrderNumber: mOrder.OrderNumber,
	}, nil
}

func (s *Server) GetOrderStatus(ctx context.Context, req *pb.GetOrderStatusRequest) (res *pb.GetOrderStatusResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetOrderStatus grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			res = &pb.GetOrderStatusResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mOrder, err := morder.GetMOrder(storeID, req.OrderNumber)
	if err != nil {
		panic(fmt.Errorf("failed to get mOrder status: %v", err))
	}

	var orderItems []*pb.OrderItem
	for _, item := range mOrder.Items {
		orderItems = append(orderItems, &pb.OrderItem{
			Name:      item.Name,
			Image:     item.Image,
			Quantity:  item.Quantity,
			Options:   &pb.ItemOptions{Choices: item.Options},
			ItemPrice: item.ItemPrice,
		})
	}

	return &pb.GetOrderStatusResponse{
		Success:    true,
		Error:      nil,
		Status:     mOrder.Status,
		DineIn:     mOrder.DineIn,
		Items:      orderItems,
		TotalPrice: mOrder.TotalPrice,
	}, nil
}

func (s *Server) GetOrderList(ctx context.Context, req *pb.GetOrderListRequest) (res *pb.GetOrderListResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetOrderList grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			res = &pb.GetOrderListResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mOrders, err := morder.GetMOrderList(storeID)
	if err != nil {
		panic(fmt.Errorf("failed to get order list: %v", err))
	}

	var summaries []*pb.ViewOrderSummary
	for _, order := range mOrders {
		summaries = append(summaries, &pb.ViewOrderSummary{
			OrderNumber: order.OrderNumber,
			Status:      order.Status,
			CreatedAt:   order.CreatedAt.Format(time.RFC3339), // ISO 형식 문자열
		})
	}

	return &pb.GetOrderListResponse{
		Success: true,
		Error:   nil,
		Orders:  summaries,
	}, nil
}

func (s *Server) UpdateOrderStatus(ctx context.Context, req *pb.UpdateOrderStatusRequest) (res *pb.UpdateOrderStatusResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in UpdateOrderStatus grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			res = &pb.UpdateOrderStatusResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mOrder, err := morder.GetMOrder(storeID, req.OrderNumber)
	if err != nil {
		panic(fmt.Errorf("failed to get order: %v", err))
	}
	if mOrder == nil {
		return &pb.UpdateOrderStatusResponse{
			Success: false,
			Error:   pb.EError_EE_ORDER_NOT_FOUND.Enum(),
		}, status.Errorf(codes.NotFound, "order not found: orderNumber=%d", req.OrderNumber)
	}

	err = morder.UpdateMOrderStatus(storeID, req.OrderNumber, req.Status)
	if err != nil {
		panic(fmt.Errorf("failed to update order status: %v", err))
	}

	return &pb.UpdateOrderStatusResponse{
		Success: true,
		Error:   nil,
		Status:  req.Status,
	}, nil
}

func itemsToString(items *[]dbstructure.MOrderItem) string {
	var result strings.Builder
	for _, item := range *items {
		var opts []string
		for _, v := range item.Options {
			opts = append(opts, fmt.Sprintf("%s", v))
		}
		options := strings.Join(opts, " ")
		result.WriteString(fmt.Sprintf("%s %s %d잔\n", item.Name, options, item.Quantity))
	}
	return result.String()
}
