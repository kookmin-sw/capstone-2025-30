package morder

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	pb "server/gen"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"
	"time"
)

func CreateMOrder(mOrder *dbstructure.MOrder) error {

	orderNumber, err := GetNextOrderNumber(mOrder.StoreCode)
	if err != nil {
		return err
	}

	mOrder.OrderNumber = orderNumber
	mOrder.Status = pb.OrderStatus_ORDER_PENDING
	mOrder.CreatedAt = time.Now()
	mOrder.UpdatedAt = time.Now()

	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sc mongo.SessionContext) (interface{}, error) {
		_, err := mongodb.OrderColl.InsertOne(sc, mOrder)
		return nil, err
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}

func GetMOrderStatus(storeCode string, orderNumber int32) (*dbstructure.MOrder, error) {
	filter := bson.M{
		"store_code":   storeCode,
		"order_number": orderNumber,
	}

	var order dbstructure.MOrder

	err := mongodb.OrderColl.FindOne(context.Background(), filter).Decode(&order)
	if err == mongo.ErrNoDocuments {
		return nil, nil // 주문 없음
	}
	if err != nil {
		return nil, err
	}

	return &order, nil
}

func GetMOrderList(storeCode string) ([]dbstructure.MOrder, error) {
	filter := bson.M{"store_code": storeCode}
	ctx := context.Background()

	opts := options.Find().SetSort(bson.D{{"created_at", -1}}).SetLimit(100)

	cursor, err := mongodb.OrderColl.Find(ctx, filter, opts)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)

	var orders []dbstructure.MOrder
	for cursor.Next(context.Background()) {
		var order dbstructure.MOrder
		if err := cursor.Decode(&order); err != nil {
			return nil, err
		}
		orders = append(orders, order)
	}

	return orders, nil
}

func UpdateMOrderStatus(storeCode string, orderNumber int32, newStatus pb.OrderStatus) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sc mongo.SessionContext) (interface{}, error) {
		filter := bson.M{
			"store_code":   storeCode,
			"order_number": orderNumber,
		}
		update := bson.M{
			"$set": bson.M{
				"status":     newStatus,
				"updated_at": time.Now(),
			},
		}

		_, err := mongodb.OrderColl.UpdateOne(sc, filter, update)
		if err != nil {
			return nil, err
		}
		return nil, nil
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}
