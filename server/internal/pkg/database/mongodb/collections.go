package mongodb

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var (
	UserColl  = &mongo.Collection{}
	StoreColl = &mongo.Collection{}
)

func defineCollections() {
	UserColl = Client.Database(name).Collection("user")
	StoreColl = Client.Database(name).Collection("store")
}

// 인덱스 생성
func CreateIndexes() {
	_, err := StoreColl.Indexes().CreateOne(context.TODO(), mongo.IndexModel{
		Keys:    bson.M{"store_code": 1},
		Options: options.Index().SetUnique(true),
	})
	if err != nil {
		panic(err)
	}
}
