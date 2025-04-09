package mstore

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"
)

func UpsertMStore(mStore *dbstructure.MStore) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sessionContext mongo.SessionContext) (interface{}, error) {
		filter := bson.D{{"store_code", mStore.StoreCode}}
		update := bson.D{{"$set", mStore}}

		_, err := mongodb.StoreColl.UpdateOne(sessionContext, filter, update, options.Update().SetUpsert(true))
		if err != nil {
			return nil, err
		}

		return nil, nil
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}
