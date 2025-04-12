package mstore

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
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
		_, err := mongodb.StoreColl.InsertOne(sessionContext, mStore)
		return nil, err
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}

func UpdateMStore(mStore *dbstructure.MStore) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sessionContext mongo.SessionContext) (interface{}, error) {
		filter := bson.D{{"store_code", mStore.StoreCode}}
		update := bson.D{{"$set", bson.D{
			{"name", mStore.Name},
			{"location", mStore.Location},
		}}}

		_, err := mongodb.StoreColl.UpdateOne(sessionContext, filter, update, options.Update().SetUpsert(true))
		if err != nil {
			return nil, err
		}

		return nil, nil
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}

// 단순 조회용 함수 : 세션, 트랜잭션 사용 안 함
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

func GetMStore(storeCode string) (*dbstructure.MStore, error) {
	filter := bson.D{{"store_code", storeCode}}
	var result dbstructure.MStore

	err := mongodb.StoreColl.FindOne(context.Background(), filter).Decode(&result)
	if err == mongo.ErrNoDocuments {
		return nil, nil
	} else if err != nil {
		return nil, err
	}

	return &result, nil
}

// store 삭제 -> 해당 store의 menu들도 같이 삭제
func DeleteMStore(storeCode string) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sessionContext mongo.SessionContext) (interface{}, error) {
		// 1. Store 삭제
		_, err := mongodb.StoreColl.DeleteOne(sessionContext, bson.M{"store_code": storeCode})
		if err != nil {
			return nil, err
		}

		// 2. 관련 Menu 삭제
		// _, err = mongodb.MenuColl.DeleteMany(sc, bson.M{"store_code": storeCode})
		// if err != nil {
		//     return nil, err
		// }

		return nil, nil
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}
