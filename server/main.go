package main

import (
	"github.com/sirupsen/logrus"
	"server/internal/database/mongodb"
)

func main() {
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
