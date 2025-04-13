package mongodb

import (
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type CollectionIndexes struct {
	Name    string
	Indexes []mongo.IndexModel
}

var MenuIndexes CollectionIndexes = CollectionIndexes{
	Name: "menu",
	Indexes: []mongo.IndexModel{
		{
			Keys: bson.D{
				{Key: "store_code", Value: 1},
				{Key: "category", Value: 1},
			},
			Options: options.Index().SetName("Menu_storeCode_category_Index"),
		},
		{
			Keys: bson.D{
				{Key: "store_code", Value: 1},
				{Key: "category", Value: 1},
				{Key: "name", Value: 1},
			},
			Options: options.Index().SetName("Menu_storeCode_category_name_Index").SetUnique(true),
		},
	},
}

var indexes []CollectionIndexes = []CollectionIndexes{
	MenuIndexes,
}
