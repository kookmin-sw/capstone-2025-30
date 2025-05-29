package mmessage

import (
	"context"
	"go.mongodb.org/mongo-driver/mongo"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"
	"time"

	"go.mongodb.org/mongo-driver/mongo/options"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func GetNotFinishedMNotificationMessageList(storeID *primitive.ObjectID) ([]dbstructure.MNotificationMessage, error) {
	filter := bson.M{
		"store_code": storeID,
		"accepted":   true,
		"finished":   false,
		"deleted":    false,
	}

	opts := options.Find().SetSort(bson.D{{"updated_at", -1}})

	cursor, err := mongodb.NotificationColl.Find(context.Background(), filter, opts)
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
		"finished":   true,
		"deleted":    false,
	}

	opts := options.Find().SetSort(bson.D{{"updated_at", -1}})

	cursor, err := mongodb.NotificationColl.Find(context.Background(), filter, opts)
	if err != nil {
		return nil, err
	}

	var notificationMessages []dbstructure.MNotificationMessage
	if err := cursor.All(context.Background(), &notificationMessages); err != nil {
		return nil, err
	}

	return notificationMessages, nil
}

func GetNotificationMessage(storeID *primitive.ObjectID, notificationTitle string, number int) (*dbstructure.MNotificationMessage, error) {
	filter := bson.M{
		"store_code": storeID,
		"title":      notificationTitle,
		"number":     number,
	}

	var notificationMessage dbstructure.MNotificationMessage
	err := mongodb.NotificationColl.FindOne(context.Background(), filter).Decode(&notificationMessage)
	if err != nil {
		return nil, err
	}

	return &notificationMessage, nil
}

func UpdateMNotificationAccepted(storeID *primitive.ObjectID, notificationTitle string, orderNumber int32, accepted bool) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sc mongo.SessionContext) (interface{}, error) {
		update_at := time.Now()
		notificationFilter := bson.M{
			"store_code": storeID,
			"title":      notificationTitle,
			"number":     orderNumber,
		}
		notificationUpdate := bson.M{
			"$set": bson.M{
				"accepted":   accepted,
				"updated_at": update_at,
			},
		}

		_, err = mongodb.NotificationColl.UpdateOne(sc, notificationFilter, notificationUpdate)
		if err != nil {
			return nil, err
		}

		return nil, nil
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}
func UpdateMNotificationFinished(storeID *primitive.ObjectID, notificationTitle string, number int32, finished bool) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sc mongo.SessionContext) (interface{}, error) {
		update_at := time.Now()
		notificationFilter := bson.M{
			"store_code": storeID,
			"title":      notificationTitle,
			"number":     number,
		}
		notificationUpdate := bson.M{
			"$set": bson.M{
				"finished":   finished,
				"updated_at": update_at,
			},
		}

		_, err = mongodb.NotificationColl.UpdateOne(sc, notificationFilter, notificationUpdate)
		if err != nil {
			return nil, err
		}

		return nil, nil
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}
