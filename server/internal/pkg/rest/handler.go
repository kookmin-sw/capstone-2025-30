package rest

import (
	"github.com/gin-gonic/gin"
	"net/http"
	pb "server/gen"
)

type RestHandler struct {
	GRPCClient pb.APIServiceClient
}

func NewRestHandler(grpcClient pb.APIServiceClient) *RestHandler {
	return &RestHandler{
		GRPCClient: grpcClient,
	}
}

func BindJSONOrError(c *gin.Context, obj interface{}) bool {
	if err := c.ShouldBindJSON(obj); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return false
	}
	return true
}
