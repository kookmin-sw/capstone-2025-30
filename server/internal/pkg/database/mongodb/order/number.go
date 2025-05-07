package morder

import (
	"context"
	"server/internal/pkg/database/mongodb"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

const (
	OrderNumberMin = 101
	OrderNumberMax = 999
)

// 매장별 주문 번호 초기화
func ensureCounterInitialized(counterType, storeCode string) error {
	filter := bson.M{"_id": counterType + "_" + storeCode}
	err := mongodb.CounterColl.FindOne(context.Background(), filter).Err()
	if err == mongo.ErrNoDocuments {
		_, err := mongodb.CounterColl.InsertOne(context.Background(), bson.M{
			"_id": counterType + "_" + storeCode,
			"seq": 100,
		})
		return err
	}
	return nil
}

func GetNextCounterNumber(counterType, storeCode string) (int32, error) {
	if err := ensureCounterInitialized(counterType, storeCode); err != nil {
		return 0, err
	}

	collection := mongodb.CounterColl
	filter := bson.M{"_id": counterType + "_" + storeCode}
	update := bson.M{"$inc": bson.M{"seq": 1}}
	opts := options.FindOneAndUpdate().SetReturnDocument(options.After)

	var counter struct {
		Seq int32 `bson:"seq"`
	}

	err := collection.FindOneAndUpdate(context.Background(), filter, update, opts).Decode(&counter)
	if err != nil {
		return 0, err
	}

	if counter.Seq > OrderNumberMax {
		resetUpdate := bson.M{
			"$set": bson.M{"seq": OrderNumberMin},
		}
		err := collection.FindOneAndUpdate(context.Background(), filter, resetUpdate, opts).Decode(&counter)
		if err != nil {
			return 0, err
		}
	}

	return counter.Seq, nil
}
