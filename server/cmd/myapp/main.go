package main

import (
	"github.com/joho/godotenv"
	"github.com/sirupsen/logrus"
	"net/http"
	"os"
	"server/internal/pkg/database/mongodb"
	grpcHandler "server/internal/pkg/grpc"
	"server/internal/pkg/rest"
	"server/internal/pkg/websocket"
)

func main() {
	setEnv()

	initialize()
}

func initialize() {
	defer func() {
		if r := recover(); r != nil {
			logrus.Println("Recovered from panic during initialization:", r)
		}
	}()

	mongodb.Initialize()
	go func() {
		http.HandleFunc("/ws", websocketHandler.WebSocketHandler)

		logrus.Infof("Websocket server is running on port %s", os.Getenv("WEBSOCKET_PORT"))

		logrus.Fatal(http.ListenAndServe(":"+os.Getenv("WEBSOCKET_PORT"), nil))
	}()

	go grpcHandler.Initialize()

	rest.Initialize()
}

func setEnv() {
	env := os.Getenv("APP_ENV")
	if env != "dev" {
		env = "prod"
	}

	var envFile string
	switch env {
	case "dev":
		envFile = ".dev.env"

	default:
		envFile = ".env"
	}

	err := error(nil)
	if env == "dev" {
		err = godotenv.Load(envFile)
	}

	if err != nil {
		logrus.Fatalf("Error loading .env file : " + err.Error())
	}
}
