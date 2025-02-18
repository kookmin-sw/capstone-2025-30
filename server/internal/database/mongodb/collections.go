package mongodb

import "go.mongodb.org/mongo-driver/mongo"

var (
	UserColl = &mongo.Collection{}
)

func defineCollections() {
	UserColl = Client.Database(name).Collection("user")
}
