package mmessage

import (
	"context"
	"go.mongodb.org/mongo-driver/mongo"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"
)

func CreateMMessage(mMessage *dbstructure.MMessage) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sc mongo.SessionContext) (interface{}, error) {
		_, err := mongodb.MessageColl.InsertOne(sc, mMessage)
		return nil, err
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}
