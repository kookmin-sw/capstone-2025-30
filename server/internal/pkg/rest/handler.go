package rest

import (
	"github.com/gin-gonic/gin"
	"os"
)

var (
	XApiKey  string
	GrpcHost string
	GrpcAddr string
)

func Initialize() {
	XApiKey = os.Getenv("REST_API_X_API_KEY")
	GrpcHost = os.Getenv("GRPC_PORT")
	GrpcAddr = ":" + GrpcHost
	env := os.Getenv("APP_ENV")
	if env != "dev" {
		gin.SetMode(gin.ReleaseMode)
	}
	r := gin.Default()
	//r.Use() 인증, panic

	r.POST("/rest/add-test-struct", AddTestStruct)
}
