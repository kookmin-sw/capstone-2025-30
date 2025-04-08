package rest

import (
	"github.com/gin-gonic/gin"
	"google.golang.org/grpc"
	pb "server/gen"
	storeRoutes "server/internal/pkg/rest/store"
)

func SetupRouter(grpcConn *grpc.ClientConn) *gin.Engine {
	r := gin.Default()
	r.Use(APIKeyAuthMiddleware)

	// gRPC 클라이언트 준비
	storeClient := pb.NewStoreServiceClient(grpcConn)

	// REST API 그룹핑 및 라우터 등록
	storeGroup := r.Group("/store")
	storeRoutes.RegisterRoutes(storeGroup, storeClient)

	return r
}
