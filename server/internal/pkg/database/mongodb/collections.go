package mongodb

import "go.mongodb.org/mongo-driver/mongo"

var (
	UserColl         = &mongo.Collection{}
	StoreColl        = &mongo.Collection{}
	MenuColl         = &mongo.Collection{}
	OrderColl        = &mongo.Collection{}
	CounterColl      = &mongo.Collection{}
	NotificationColl = &mongo.Collection{}
	MessageColl      = &mongo.Collection{}
	FastInquiryColl  = &mongo.Collection{}
)

func defineCollections() {
	UserColl = Client.Database(name).Collection("user")
	StoreColl = Client.Database(name).Collection("store")
	MenuColl = Client.Database(name).Collection("store_menu")
	OrderColl = Client.Database(name).Collection("order")
	CounterColl = Client.Database(name).Collection("order_counter")
	NotificationColl = Client.Database(name).Collection("notification")
	MessageColl = Client.Database(name).Collection("message")
	FastInquiryColl = Client.Database(name).Collection("fast_inquiry")
}
