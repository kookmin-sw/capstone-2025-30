package store

import (
	"github.com/gin-gonic/gin"
	pb "server/gen"
)

// RegisterRoutes 연결 함수
func RegisterRoutes(rg *gin.RouterGroup, client pb.StoreServiceClient) {
	handler := NewHandler(client)

	rg.POST("", handler.CreateStore)
	rg.GET("/:id", handler.GetStoreByID)
	rg.GET("/code/:store_code", handler.GetStoreByCode)
	rg.GET("/", handler.GetStoreList)
	rg.PUT("/:id", handler.UpdateStore)
	rg.DELETE("/:id", handler.DeleteStore)
}
