package rest

import (
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"os"
	pb "server/gen"
	"server/internal/pkg/rest/store"
)

func Initialize(grpcConn *grpc.ClientConn) {
	LoadAPIKey()

	r := gin.Default()
	r.Use(APIKeyAuthMiddleware)

	storeClient := pb.NewStoreServiceClient(grpcConn)
	store.RegisterRoutes(r.Group("/store"), storeClient)

	port := os.Getenv("REST_API_PORT")
	if port == "" {
		port = "8000"
	}
	logrus.Infof("REST server running on port %s", port)

	if err := r.Run(":" + port); err != nil {
		logrus.Fatalf("failed to run REST server: %v", err)
	}
}
