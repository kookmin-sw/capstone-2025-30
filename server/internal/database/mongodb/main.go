package mongodb

import (
	"context"
	"crypto/tls"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"os"
	"sync"
)

var (
	url  string
	name string

	Client      *mongo.Client
	ClientError error
	once        sync.Once
)

func Initialize() {
	once.Do(func() {

		url = os.Getenv("MONGO_DB_URL")
		name = os.Getenv("MONGO_DB_NAME")

		serverAPI := options.ServerAPI(options.ServerAPIVersion1)
		opts := options.Client().ApplyURI(url).SetServerAPIOptions(serverAPI)
		opts.SetMaxPoolSize(50)
		opts.SetTLSConfig(&tls.Config{MinVersion: tls.VersionTLS12})

		Client, ClientError = mongo.Connect(context.TODO(), opts)

		if ClientError != nil {
			panic(ClientError)
		} else {
			logrus.Printf("MongoDB connected successfully")
		}

		//ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		//defer cancel()
		//
		//if err := Client.Ping(ctx, nil); err != nil {
		//	logrus.Fatalf("🚨 MongoDB Ping 실패: %v", err)
		//	panic(err)
		//} else {
		//	logrus.Printf("✅ MongoDB connected successfully")
		//}

		defineCollections()
		// index 생성 할까? 말까?
	})
}
