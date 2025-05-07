package dbstructure

import "go.mongodb.org/mongo-driver/bson/primitive"

type MOption struct {
	Type        string   `bson:"type" json:"Type"`
	Choices     []string `bson:"choices" json:"Choices"`
	OptionPrice []int32  `bson:"option_price,omitempty" json:"OptionPrice"`
}

type MMenu struct {
	ID               primitive.ObjectID `bson:"_id,omitempty" json:"ID"`
	StoreID          primitive.ObjectID `bson:"store_id" json:"StoreID"`
	StoreCode        string             `bson:"store_code" json:"StoreCode"`
	Category         string             `bson:"category" json:"Category"`
	Name             string             `bson:"name" json:"Name"`
	MenuPrice        int32              `bson:"menu_price" json:"MenuPrice"`
	Options          []MOption          `bson:"options" json:"Options"`
	Description      string             `bson:"description" json:"Description"`
	SignLanguageDesc string             `bson:"sign_language_description" json:"SignLanguageDesc"`
	SignLanguageURLs []string           `bson:"sign_language_urls" json:"SignLanguageURLs"`
	Image            string             `bson:"image" json:"Image"`
}
