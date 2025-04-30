package mmessage

import (
	"context"
	"fmt"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func CreateMMessage(mMessage *dbstructure.MMessage) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sc mongo.SessionContext) (interface{}, error) {
		_, err := mongodb.MessageColl.InsertOne(sc, mMessage)
		return nil, err
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}

func GetMMessage(storeID *primitive.ObjectID, num int32, notificationTitle string) ([]dbstructure.MMessage, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	filter := bson.M{
		"store_id": storeID,
		"number":   num,
		"title":    notificationTitle,
	}

	// created_at 기준 오름차순 정렬 옵션 설정
	opts := options.Find().SetSort(bson.D{{"created_at", 1}})

	cursor, err := mongodb.MessageColl.Find(ctx, filter, opts)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)

	var messages []dbstructure.MMessage
	if err = cursor.All(ctx, &messages); err != nil {
		return nil, err
	}

	// 결과가 없으면 에러 반환
	if len(messages) == 0 {
		return nil, fmt.Errorf("no messages found for store_id: %s, number: %d title : %s", storeID.Hex(), num, notificationTitle)
	}

	return messages, nil
}
