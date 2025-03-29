package rest

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func AddTestStruct(c *gin.Context) {
	var req struct {
		Name  string `json:"name"`
		Value int    `json:"value"`
	}
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "요청 잘 받았음!",
		"data":    req,
	})
}
