package grpcHandler

import (
	"context"
	"fmt"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	pb "server/gen"
	mmenu "server/internal/pkg/database/mongodb/menu"
	morder "server/internal/pkg/database/mongodb/order"
	mstore "server/internal/pkg/database/mongodb/store"
	dbstructure "server/internal/pkg/database/structure"
	"server/internal/pkg/utils"
	"time"
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
	mOrder := dbstructure.MOrder{
		ID:         primitive.NewObjectID(),
		StoreID:    storeID,
		StoreCode:  req.StoreCode,
		DineIn:     req.DineIn,
		Status:     pb.OrderStatus_ORDER_PENDING,
		Items:      items,
		TotalPrice: req.TotalPrice,
		CreatedAt:  time.Now(),
		UpdatedAt:  time.Now(),
	}

	// DB 저장 (번호 포함됨)
	err = morder.CreateMOrder(&mOrder)
	if err != nil {
		panic(fmt.Errorf("failed to create order: %v", err))
	}

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

	mOrder, err := morder.GetMOrderStatus(storeID, req.OrderNumber)
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
