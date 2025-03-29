package rest

import (
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"net/http"
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
	r.Use(apiKeyAuthMiddleware)

	r.POST("/rest/add-test-struct", AddTestStruct)

	port := os.Getenv("REST_API_PORT")
	_ = r.Run(":" + port)
	logrus.Infof("Rest API server is running on port %s", port)
}

func apiKeyAuthMiddleware(c *gin.Context) {
	apiKey := c.GetHeader("api-key")
	if apiKey != XApiKey {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid API key"})
		c.Abort() // 중지해 요청이 다음 단계로 넘어가지 않도록 함
		return
	}
	c.Next() // API 키가 유효한 경우 다음 핸들러로 요청 전달
}
