package mongodb

import "go.mongodb.org/mongo-driver/mongo"

var (
	UserColl  = &mongo.Collection{}
	StoreColl = &mongo.Collection{}
)

func defineCollections() {
	UserColl = Client.Database(name).Collection("user")
	StoreColl = Client.Database(name).Collection("store")
}
