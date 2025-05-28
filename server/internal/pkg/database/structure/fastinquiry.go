package dbstructure

import "go.mongodb.org/mongo-driver/bson/primitive"

type FastInquiry struct {
	ID        primitive.ObjectID `bson:"_id,omitempty" json:"ID"`
	Name      string             `bson:"name" json:"Name"`
	InquiryNo int32              `bson:"inquiry_no" json:"InquiryNo"`
	URLs      []string           `bson:"urls" json:"URLs"`
}
