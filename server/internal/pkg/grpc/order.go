package grpcHandler

import (
	"context"
	"fmt"
	"go.mongodb.org/mongo-driver/mongo"
	pb "server/gen"
	mmenu "server/internal/pkg/database/mongodb/menu"
	mmessage "server/internal/pkg/database/mongodb/message"
	morder "server/internal/pkg/database/mongodb/order"
	mstore "server/internal/pkg/database/mongodb/store"
	dbstructure "server/internal/pkg/database/structure"
	"server/internal/pkg/utils"
	"strings"
	"time"

	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (s *Server) CreateOrder(ctx context.Context, req *pb.CreateOrderRequest) (res *pb.CreateOrderResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[gRPC CreateOrder] panic: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
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

		exists, err := mmenu.IsMenuExists(storeID, item.Name)
		if err != nil {
			logrus.Errorf("[gRPC CreateOrder] Failed to search a menu for %s", item.Name)
			panic(pb.EError_EE_DB_OPERATION_FAILED)
		}
		if !exists {
			logrus.Errorf("[gRPC CreateOrder] Menu not found for %s", item.Name)
			panic(pb.EError_EE_MENU_NOT_FOUND)
		}
		image, err := mmenu.FindMenuImage(storeID, item.Name)
		if err != nil {
			logrus.Errorf("[gRPC CreateOrder] Image not found for %s: %v", item.Name, err)
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
		Finished:          false,
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
		IsOwner:   false,
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
			logrus.Error("[gRPC GetOrderStatus] panic: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			res = &pb.GetOrderStatusResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		logrus.Errorf("[gRPC GetOrderStatus] Store Id is not founded by store code(%s): %v", req.StoreCode, err)
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mOrder, err := morder.GetMOrder(storeID, req.OrderNumber)
	if err != nil {
		logrus.Errorf("[gRPC GetOrderStatus] Failed to get OrderStatus from mOrder")
		panic(pb.EError_EE_DB_OPERATION_FAILED)
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
			logrus.Error("[gRPC GetOrderList] panic: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			res = &pb.GetOrderListResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		logrus.Errorf("[gRPC GetOrderList] Store Id is not founded by store code(%s): %v", req.StoreCode, err)
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mOrders, err := morder.GetMOrderList(storeID)
	if err != nil {
		logrus.Errorf("[gRPC GetOrderList] Failed to get order list from mOrder")
		panic(pb.EError_EE_DB_OPERATION_FAILED)
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
			logrus.Error("[gRPC UpdateOrderStatus] panic: ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = nil
			res = &pb.UpdateOrderStatusResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		logrus.Errorf("[gRPC UpdateOrderStatus] Store Id is not founded by store code(%s): %v", req.StoreCode, err)
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	_, err = morder.GetMOrder(storeID, req.OrderNumber)
	if err == mongo.ErrNoDocuments {
		logrus.Errorf("[gRPC UpdateOrderStatus] Order is not founded")
		panic(pb.EError_EE_ORDER_NOT_FOUND)
	}
	if err != nil {
		logrus.Errorf("[gRPC UpdateOrderStatus] Failed to update order status from mOrder")
		panic(pb.EError_EE_DB_OPERATION_FAILED)
	}

	mNotification, err := mmessage.GetNotificationMessage(&storeID, "order", int(req.OrderNumber))
	if err != nil {
		logrus.Errorf("[gRPC UpdateOrderStatus] Failed to get notification")
		panic(err)
	}
	if mNotification == nil {
		logrus.Errorf("[gRPC UpdateOrderStatus] Notification is not founded")
		panic(pb.EError_EE_NOTIFICATION_NOT_FOUND)
	}

	err = morder.UpdateMOrderStatusAndMNotificationFinished(storeID, req.OrderNumber, req.Status, true)
	if err != nil {
		logrus.Errorf("[gRPC UpdateOrderStatus] Failed to update order status and notification accepted")
		panic(pb.EError_EE_DB_OPERATION_FAILED)
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
