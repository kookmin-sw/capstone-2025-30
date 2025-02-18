package main

import (
	"github.com/joho/godotenv"
	"github.com/sirupsen/logrus"
	"os"
	"server/internal/pkg/database/mongodb"
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
		envFile = ".prod.env"
	}

	err := godotenv.Load(envFile)

	if err != nil {
		logrus.Fatalf("Error loading .env file")
	}
}
