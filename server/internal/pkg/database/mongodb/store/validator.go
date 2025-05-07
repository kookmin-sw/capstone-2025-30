package mstore

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"server/internal/pkg/database/mongodb"
	"time"
)

func ValidateStoreCodeAndGetObjectID(storeCode string) (primitive.ObjectID, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	filter := bson.M{"store_code": storeCode}

	var result struct {
		ID primitive.ObjectID `bson:"_id"`
	}

	err := mongodb.StoreColl.FindOne(ctx, filter).Decode(&result)
	if err != nil {
		return primitive.NilObjectID, err
	}

	return result.ID, nil
}
