package mstore

import (
	"context"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"
)

func CreateMStore(mStore *dbstructure.MStore) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sessionContext mongo.SessionContext) (interface{}, error) {
		_, err = mongodb.StoreColl.InsertOne(sessionContext, mStore)
		return nil, err
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}

func GetMStoreList() ([]dbstructure.MStore, error) {
	cursor, err := mongodb.StoreColl.Find(context.Background(), bson.D{})
	if err != nil {
		return nil, err
	}
	defer cursor.Close(context.Background())

	var stores []dbstructure.MStore
	for cursor.Next(context.Background()) {
		var store dbstructure.MStore
		if err := cursor.Decode(&store); err != nil {
			return nil, err
		}
		stores = append(stores, store)
	}

	return stores, nil
}

func GetMStore(storeID primitive.ObjectID) (*dbstructure.MStore, error) {
	filter := bson.D{{"_id", storeID}}
	var result dbstructure.MStore

	err := mongodb.StoreColl.FindOne(context.Background(), filter).Decode(&result)
	if err != nil {
		return nil, err
	}

	return &result, nil
}

func UpdateMStore(mStore *dbstructure.MStore) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sessionContext mongo.SessionContext) (interface{}, error) {
		filter := bson.D{{"_id", mStore.ID}}
		update := bson.D{{"$set", bson.D{
			{"name", mStore.Name},
			{"location", mStore.Location},
		}}}

		_, err := mongodb.StoreColl.UpdateOne(sessionContext, filter, update, options.Update().SetUpsert(false))
		if err != nil {
			return nil, err
		}

		return nil, nil
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}

func DeleteMStore(storeID primitive.ObjectID) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sessionContext mongo.SessionContext) (interface{}, error) {
		// 1. Store 삭제
		_, err := mongodb.StoreColl.DeleteOne(sessionContext, bson.M{"_id": storeID})
		if err != nil {
			return nil, err
		}

		// 2. 관련 Menu 삭제
		_, err = mongodb.MenuColl.DeleteMany(sessionContext, bson.M{"store_id": storeID})
		if err != nil {
			return nil, err
		}

		return nil, nil
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}

func IsStoreExists(storeName string, location string) (bool, error) {
	filter := bson.M{
		"name":     storeName,
		"location": location,
	}
	count, err := mongodb.StoreColl.CountDocuments(context.Background(), filter)
	if err != nil {
		logrus.Errorf("[mongoDB IsStoreExists] Failed to check store existence: %v", err)
		return false, err
	}
	return count > 0, nil
}
