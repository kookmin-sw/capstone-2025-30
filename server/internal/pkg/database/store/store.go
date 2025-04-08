package model

import "go.mongodb.org/mongo-driver/bson/primitive"

type Store struct {
	ID        primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	Name      string             `bson:"name" json:"name"`
	Location  string             `bson:"location" json:"location"`
	StoreCode string             `bson:"store_code" json:"storeCode"`
}
