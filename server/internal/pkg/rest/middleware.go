package rest

import (
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"net/http"
	"os"
)

var XApiKey string

// 환경 변수로부터 X-API-KEY를 로딩
func LoadAPIKey() {
	XApiKey = os.Getenv("REST_API_X_API_KEY")
}

// API 키 검증 미들웨어
func APIKeyAuthMiddleware(c *gin.Context) {
	apiKey := c.GetHeader("api-key")
	if apiKey != XApiKey {
		logrus.Infof("📦 Header API Key: %s", apiKey)
		logrus.Infof("🔐 Expected API Key: %s", XApiKey)
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid API key"})
		c.Abort()
		return
	}
	c.Next() // 인증 성공 → 다음 핸들러로
}
