package morder

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"server/internal/pkg/database/mongodb"
)

const (
	OrderNumberMin = 101
	OrderNumberMax = 999
)

// 매장별 주문 번호 초기화
func ensureCounterInitialized(storeCode string) error {
	filter := bson.M{"_id": "order_" + storeCode} // 컬렉션에서 해당 매장의 _id = "order_<store_code>"
	err := mongodb.CounterColl.FindOne(context.Background(), filter).Err()
	// 초기 생성시
	if err == mongo.ErrNoDocuments {
		_, err := mongodb.CounterColl.InsertOne(context.Background(), bson.M{
			"_id": "order_" + storeCode,
			"seq": 100, //101번부터 시작하기 위 한 초기값 설정
		})
		return err
	}
	return nil
}

func GetNextOrderNumber(storeCode string) (int32, error) {
	// 초기화
	if err := ensureCounterInitialized(storeCode); err != nil {
		return 0, err
	}

	collection := mongodb.CounterColl

	// seq 1 증가
	filter := bson.M{"_id": "order_" + storeCode}
	update := bson.M{"$inc": bson.M{"seq": 1}} // $inc : 해당 document 의 seq 값을 1 증가시킴
	opts := options.FindOneAndUpdate().
		SetReturnDocument(options.After)

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
