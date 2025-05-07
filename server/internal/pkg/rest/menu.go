package rest

import (
	"context"
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/metadata"
	"net/http"
	"os"
	pb "server/gen"
	"server/internal/pkg/utils"
)

func (h *RestHandler) CreateMenu(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST CreateMenu] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	storeCode := c.Param("store_code")
	if storeCode == "" {
		logrus.Error("[REST CreateMenu] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	type CreateMenuBody struct {
		Category    string       `json:"category" binding:"required"`
		Name        string       `json:"name" binding:"required"`
		MenuPrice   int32        `json:"menu_price" binding:"required"`
		Description string       `json:"description"`
		SignDesc    string       `json:"sign_language_description"`
		SignURLs    []string     `json:"sign_language_urls"`
		Options     []*pb.Option `json:"options"`
		Image       string       `json:"image"`
	}

	var req CreateMenuBody
	if err := c.ShouldBindJSON(&req); err != nil {
		logrus.Errorf("[REST CreateMenu] Failed to JSON Binding: %v", err)
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.CreateMenuRequest{
		StoreCode:               storeCode,
		Category:                req.Category,
		Name:                    req.Name,
		MenuPrice:               req.MenuPrice,
		Description:             req.Description,
		SignLanguageDescription: req.SignDesc,
		SignLanguageUrls:        req.SignURLs,
		Options:                 req.Options,
		Image:                   req.Image,
	}

	grpcRes, err := authClient.CreateMenu(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("[REST CreateMenu] Failed to Call CreateMenu grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST CreateMenu] Failed by CreateMenu grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"error":   nil,
		"menu":    grpcRes.GetMenu(),
	})
}

func (h *RestHandler) GetCategoryList(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST GetCategoryList] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	storeCode := c.Param("store_code")
	if storeCode == "" {
		logrus.Error("[REST GetCategoryList] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcRes, err := authClient.GetCategoryList(ctx, &pb.GetCategoryListRequest{
		StoreCode: storeCode,
	})

	if err != nil {
		logrus.Errorf("[REST GetCategoryList] Failed to Call GetCategoryList grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST GetCategoryList] Failed by GetCategoryList grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success":    true,
		"error":      nil,
		"categories": grpcRes.GetCategories(),
	})
}

func (h *RestHandler) GetMenuList(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST GetMenuList] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{"" +
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	storeCode := c.Param("store_code")
	if storeCode == "" {
		logrus.Error("[REST GetMenuList] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	category := c.Query("category")
	if category == "" {
		logrus.Error("[REST GetMenuList] Category is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.GetMenuListRequest{
		StoreCode: storeCode,
		Category:  category,
	}

	grpcRes, err := authClient.GetMenuList(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("[REST GetMenuList] Failed to Call GetMenuList grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST GetMenuList] Failed by GetMenuList grpc: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"error":   nil,
		"menus":   grpcRes.GetMenus(),
	})
}

func (h *RestHandler) GetMenuDetail(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("[REST GetMenuDetail] panic: ", r)
			e := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			status := utils.HTTPStatusFromEError(e)
			c.JSON(status, gin.H{
				"success": false,
				"error":   e,
				"message": e.String(),
			})
		}
	}()

	storeCode := c.Param("store_code")
	if storeCode == "" {
		logrus.Error("[REST GetMenuDetail] StoreCode is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	category := c.Query("category")
	if category == "" {
		logrus.Error("[REST GetMenuDetail] Category is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	name := c.Query("name")
	if name == "" {
		logrus.Error("[REST GetMenuDetail] Name(of Menu) is required")
		panic(pb.EError_EE_INVALID_ARGUMENT)
	}

	authClient := pb.NewAPIServiceClient(GrpcClientConn)
	logrus.Infof("GrpcClientConn is nil? %v", GrpcClientConn == nil)

	grpcApiKey := os.Getenv("ALLOWED_AUTH_KEY")
	logrus.Infof("GrpcApiKey: %s", grpcApiKey)

	md := metadata.New(map[string]string{"api-key": grpcApiKey})
	ctx := metadata.NewOutgoingContext(context.Background(), md)

	grpcReq := &pb.GetMenuDetailRequest{
		StoreCode: storeCode,
		Category:  category,
		Name:      name,
	}

	grpcRes, err := authClient.GetMenuDetail(ctx, grpcReq)
	if err != nil {
		logrus.Errorf("[REST GetMenuDetail] Failed to Call GetMenuDetail grpc: %v", err)
		panic(err)
	}

	if !grpcRes.GetSuccess() {
		logrus.Errorf("[REST GetMenuDetail] Failed by GetMenuDetail gRPC: %v", grpcRes.GetError())
		c.JSON(utils.HTTPStatusFromEError(grpcRes.GetError()), gin.H{
			"success": grpcRes.GetSuccess(),
			"error":   grpcRes.GetError(),
			"message": grpcRes.GetError().String(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"error":   nil,
		"menu":    grpcRes.GetMenu(),
	})
}
