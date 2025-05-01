package mmessage

import (
	"context"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func GetNotFinishedMNotificationMessageList(storeID *primitive.ObjectID) ([]dbstructure.MNotificationMessage, error) {
	filter := bson.M{
		"store_code": storeID,
		"accepted":   false,
		"deleted":    false,
	}

	cursor, err := mongodb.NotificationColl.Find(context.Background(), filter)
	if err != nil {
		return nil, err
	}

	var notificationMessages []dbstructure.MNotificationMessage
	if err := cursor.All(context.Background(), &notificationMessages); err != nil {
		return nil, err
	}

	return notificationMessages, nil
}

func GetFinishedMNotificationMessageList(storeID *primitive.ObjectID) ([]dbstructure.MNotificationMessage, error) {
	filter := bson.M{
		"store_code": storeID,
		"accepted":   true,
		"deleted":    false,
	}

	cursor, err := mongodb.NotificationColl.Find(context.Background(), filter)
	if err != nil {
		return nil, err
	}

	var notificationMessages []dbstructure.MNotificationMessage
	if err := cursor.All(context.Background(), &notificationMessages); err != nil {
		return nil, err
	}

	return notificationMessages, nil
}
