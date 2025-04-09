package dbstructure

import "go.mongodb.org/mongo-driver/bson/primitive"

type MStore struct {
	ID        primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	Name      string             `bson:"name" json:"name"`
	Location  string             `bson:"location" json:"location"`
	StoreCode string             `bson:"store_code" json:"storeCode"`
}
