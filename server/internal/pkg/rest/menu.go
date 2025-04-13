package rest

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/metadata"
	"net/http"
	"os"
	pb "server/gen"
)

func (h *RestHandler) CreateMenu(c *gin.Context) {
	storeCode := c.Param("store_code")

	var req pb.CreateMenuRequest
	if !BindJSONOrError(c, &req) {
		return
	}

	req.StoreCode = storeCode

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in CreateMenu rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.CreateMenu(ctx, &req)
	if err != nil {
		logrus.Errorf("CreateMenu failed: %v", err)
		//c.JSON(http.StatusBadRequest, gin.H{
		//	"success": grpcRes.GetSuccess(),        // false
		//	"error":   grpcRes.GetError().String(), // "EE_STORE_NOT_FOUND"
		//})
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
		"menu":    grpcRes.GetMenu(),
	})
}

func (h *RestHandler) GetCategoryList(c *gin.Context) {
	storeCode := c.Param("store_code")

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetCategoryList rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.GetCategoryList(ctx, &pb.GetCategoryListRequest{
		StoreCode: storeCode,
	})

	if err != nil {
		logrus.Errorf("GetCategoryList failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success":    grpcRes.GetSuccess(),
		"error":      grpcRes.GetError(),
		"categories": grpcRes.GetCategories(),
	})
}

func (h *RestHandler) GetMenuList(c *gin.Context) {
	storeCode := c.Param("store_code")
	category := c.Query("category")

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetMenuList rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.GetMenuListRequest{
		StoreCode: storeCode,
		Category:  category,
	}

	grpcRes, err := authClient.GetMenuList(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("GetMenuList failed: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
		"menus":   grpcRes.GetMenus(),
	})
}

func (h *RestHandler) GetMenuDetail(c *gin.Context) {
	storeCode := c.Param("store_code")
	category := c.Query("category")
	name := c.Query("name")

	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetMenuDetail rest api : ", r)
			c.JSON(http.StatusInternalServerError, gin.H{"error": r})
		}
	}()

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.GetMenuDetailRequest{
		StoreCode: storeCode,
		Category:  category,
		Name:      name,
	}

	grpcRes, err := authClient.GetMenuDetail(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("GetMenuDetail failed: %v", err)
		c.JSON(http.StatusNotFound, gin.H{"error": "menu not found"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": grpcRes.GetSuccess(),
		"error":   grpcRes.GetError(),
		"menu":    grpcRes.GetMenu(),
	})
}
