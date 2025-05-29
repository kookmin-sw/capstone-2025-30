package rest

import (
	"log"
	"net/http"
	"os"
	pb "server/gen"

	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

var (
	XApiKey  string
	GrpcHost string
	GrpcAddr string

	GrpcClientConn *grpc.ClientConn
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

	initGrpc()

	grpcClient := pb.NewAPIServiceClient(GrpcClientConn)
	// 핸들러 생성
	restHandler := NewRestHandler(grpcClient)

	// 테스트 api
	r.POST("/rest/add-test-struct", AddTestStruct)

	// store api
	r.POST("/rest/store", restHandler.CreateStore)
	r.GET("/rest/store/list", restHandler.GetStoreList)
	r.GET("/rest/store/:store_code", restHandler.GetStore)
	r.PUT("/rest/store/:store_code", restHandler.UpdateStore)
	r.DELETE("/rest/store/:store_code", restHandler.DeleteStore)

	// menu api
	r.POST("/rest/menu/:store_code", restHandler.CreateMenu)
	r.GET("/rest/menu/:store_code/category", restHandler.GetCategoryList)
	r.GET("/rest/menu/:store_code/menuList", restHandler.GetMenuList)
	r.GET("/rest/menu/:store_code/menuDetail", restHandler.GetMenuDetail)

	// order api
	r.POST("/rest/order/:store_code", restHandler.CreateOrder)
	r.GET("/rest/order/:store_code/:order_number", restHandler.GetOrderStatus)
	r.GET("/rest/order/:store_code/orderList", restHandler.GetOrderList)
	r.PUT("/rest/order/:store_code/:order_number/status", restHandler.UpdateOrderStatus)

	// message api
	r.GET("/rest/messages/:store_code", restHandler.GetMessages)
	r.GET("/rest/chat-room-list/:store_code", restHandler.GetMessageList)

	// inquiry api
	r.PUT("/rest/inquiry/:store_code/:inquiry_number/status", restHandler.UpdateInquiryStatus)

	port := os.Getenv("REST_API_PORT")
	_ = r.Run(":" + port)
	logrus.Infof("Rest API server is running on port %s", port)
}

func apiKeyAuthMiddleware(c *gin.Context) {
	if c.Request.Method == http.MethodOptions {
		c.Status(http.StatusOK)
		c.Abort()
		return
	}

	apiKey := c.GetHeader("api-key")
	if apiKey != XApiKey {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid API key"})
		c.Abort() // 중지해 요청이 다음 단계로 넘어가지 않도록 함
		return
	}
	c.Next() // API 키가 유효한 경우 다음 핸들러로 요청 전달
}

func initGrpc() {
	var err error
	GrpcClientConn, err = grpc.NewClient(GrpcAddr, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatal("gRPC connection failed: ", err)
	}
}
