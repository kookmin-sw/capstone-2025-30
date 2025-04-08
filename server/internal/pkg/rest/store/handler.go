package store

import (
	"context"
	"github.com/sirupsen/logrus"
	"google.golang.org/protobuf/types/known/emptypb"
	"io"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	pb "server/gen"
)

type Handler struct {
	GRPCClient pb.StoreServiceClient
}

func NewHandler(client pb.StoreServiceClient) *Handler {
	return &Handler{GRPCClient: client}
}

func (h *Handler) CreateStore(c *gin.Context) {
	logrus.Info("📥 REST CreateStore handler 호출됨")

	// JSON 요청 파싱
	var req CreateStoreRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// gRPC 요청 형식으로 변환
	grpcReq := &pb.CreateStoreRequest{
		Name:     req.Name,
		Location: req.Location,
	}
	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()
	// gRPC 서버 호출
	grpcResp, err := h.GRPCClient.CreateStore(ctx, grpcReq)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to create store"})
		return
	}

	// 응답 반환
	c.JSON(http.StatusCreated, grpcResp.Store)
}

func (h *Handler) GetStoreByID(c *gin.Context) {
	id := c.Param("id")
	grpcReq := &pb.StoreIdRequest{
		Id: id,
	}

	grpcResp, err := h.GRPCClient.GetStoreById(context.Background(), grpcReq)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "store not found"})
		return
	}

	c.JSON(http.StatusOK, grpcResp.Store)
}

func (h *Handler) GetStoreByCode(c *gin.Context) {
	code := c.Param("store_code")

	grpcReq := &pb.StoreCodeRequest{
		StoreCode: code,
	}

	grpcResp, err := h.GRPCClient.GetStoreByCode(context.Background(), grpcReq)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "store not found"})
		return
	}

	c.JSON(http.StatusOK, grpcResp.Store)
}

func (h *Handler) GetStoreList(c *gin.Context) {
	stream, err := h.GRPCClient.GetStoreList(context.Background(), &emptypb.Empty{})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to get store list"})
		return
	}

	var stores []*pb.Store
	for {
		store, err := stream.Recv()
		if err == io.EOF {
			break
		}
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to receive store"})
			return
		}
		stores = append(stores, store)
	}

	c.JSON(http.StatusOK, stores)
}

func (h *Handler) UpdateStore(c *gin.Context) {
	id := c.Param("id")

	var req UpdateStoreRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	grpcReq := &pb.UpdateStoreRequest{
		Id:       id,
		Name:     req.Name,
		Location: req.Location,
	}

	grpcResp, err := h.GRPCClient.UpdateStore(context.Background(), grpcReq)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to update store"})
		return
	}

	c.JSON(http.StatusOK, grpcResp.Store)
}

func (h *Handler) DeleteStore(c *gin.Context) {
	id := c.Param("id")

	grpcReq := &pb.DeleteStoreRequest{
		Id: id,
	}

	_, err := h.GRPCClient.DeleteStore(context.Background(), grpcReq)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "store not found or already deleted"})
		return
	}

	c.Status(http.StatusNoContent) // 204 No Content
}
