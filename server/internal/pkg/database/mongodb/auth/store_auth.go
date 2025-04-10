package mauth

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"server/internal/pkg/database/mongodb"
	"time"
)

func GetObjectIdInStore(storeId string) (*string, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	filter := bson.M{
		"store_code": storeId,
	}

	var result struct {
		ID primitive.ObjectID `bson:"_id"`
	}

	err := mongodb.StoreColl.FindOne(ctx, filter).Decode(&result)
	if err != nil {
		return nil, err
	}

	objectIDStr := result.ID.Hex()
	return &objectIDStr, nil
}
