package mmessage

//func CreateMNotificationMessage(mNotificationMessage *dbstructure.MNotificationMessage) error {
//	session, err := mongodb.Client.StartSession()
//	if err != nil {
//		return err
//	}
//	defer session.EndSession(context.Background())
//
//	callback := func(sc mongo.SessionContext) (interface{}, error) {
//		_, err := mongodb.NotificationColl.InsertOne(sc, mNotificationMessage)
//		return nil, err
//	}
//
//	_, err = session.WithTransaction(context.Background(), callback)
//	return err
//}
