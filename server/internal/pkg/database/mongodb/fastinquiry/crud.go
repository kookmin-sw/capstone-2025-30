package mfastinquiry

import (
	"context"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"

	"go.mongodb.org/mongo-driver/bson"
)

func GetFastInquiry(name string) (*dbstructure.FastInquiry, error) {
	filter := bson.M{"name": name}

	var fastInquiry dbstructure.FastInquiry
	err := mongodb.FastInquiryColl.FindOne(context.Background(), filter).Decode(&fastInquiry)
	if err != nil {
		return nil, err
	}
	return &fastInquiry, nil
}
