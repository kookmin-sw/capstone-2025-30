package morder

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo/options"
	"server/internal/pkg/database/mongodb"
)

const (
	OrderNumberMin = 101
	OrderNumberMax = 999
)

func GetNextOrderNumber(storeCode string) (int32, error) {
	collection := mongodb.CounterColl

	filter := bson.M{"_id": "order_" + storeCode}
	update := bson.M{
		"$inc": bson.M{"seq": 1},
		"$setOnInsert": bson.M{
			"seq": OrderNumberMin - 1, // 초기 생성시 100으로 설정
		},
	}
	opts := options.FindOneAndUpdate().SetUpsert(true).SetReturnDocument(options.After)

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
