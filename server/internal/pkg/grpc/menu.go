package grpcHandler

import (
	"context"
	"fmt"
	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	pb "server/gen"
	mmenu "server/internal/pkg/database/mongodb/menu"
	mstore "server/internal/pkg/database/mongodb/store"
	dbstructure "server/internal/pkg/database/structure"
	"server/internal/pkg/utils"
)

func (s *Server) CreateMenu(ctx context.Context, req *pb.CreateMenuRequest) (res *pb.CreateMenuResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in CreateMenu grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			res = &pb.CreateMenuResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	exists, err := mmenu.IsMenuExists(storeID, req.Name)
	if err != nil {
		panic(fmt.Errorf("failed to check menu existence: %v", err))
	}
	if exists {
		panic(pb.EError_EE_MENU_ALREADY_EXISTS)
	}

	mMenu := dbstructure.MMenu{
		ID:               primitive.NewObjectID(),
		StoreID:          storeID,
		StoreCode:        req.StoreCode,
		Category:         req.Category,
		Name:             req.Name,
		MenuPrice:        req.MenuPrice,
		Options:          toMOptions(req.Options),
		Description:      req.Description,
		SignLanguageDesc: req.SignLanguageDescription,
		SignLanguageURLs: req.SignLanguageUrls,
		Image:            req.Image,
	}

	err = mmenu.CreateMMenu(&mMenu)
	if err != nil {
		panic(fmt.Errorf("faild to create mMenu': %v", err))
	}

	return &pb.CreateMenuResponse{
		Success: true,
		Error:   nil,
		Menu:    toViewMenu(&mMenu),
	}, nil
}

func (s *Server) GetCategoryList(ctx context.Context, req *pb.GetCategoryListRequest) (res *pb.GetCategoryListResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetCategoryList grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			res = &pb.GetCategoryListResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	categories, err := mmenu.GetCategoryList(storeID)
	if err != nil {
		panic(fmt.Errorf("failed to get category list from mStore: %v", err))
	}

	return &pb.GetCategoryListResponse{
		Success:    true,
		Error:      nil,
		Categories: categories,
	}, nil
}

func (s *Server) GetMenuList(ctx context.Context, req *pb.GetMenuListRequest) (res *pb.GetMenuListResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetMenuList grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			res = &pb.GetMenuListResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mMenus, err := mmenu.GetMMenuList(storeID, req.Category)
	if err != nil {
		{
			panic(fmt.Errorf("failed to get mMenu: %v", err))
		}
	}

	var viewMenus []*pb.ViewMenu
	for _, m := range mMenus {
		viewMenus = append(viewMenus, toViewMenu(&m))
	}

	if viewMenus == nil {
		viewMenus = []*pb.ViewMenu{}
	}

	return &pb.GetMenuListResponse{
		Success: true,
		Error:   nil,
		Menus:   viewMenus,
	}, nil
}

func (s *Server) GetMenuDetail(ctx context.Context, req *pb.GetMenuDetailRequest) (res *pb.GetMenuDetailResponse, errRes error) {
	defer func() {
		if r := recover(); r != nil {
			logrus.Error("defer in GetMenuDetail grpc api : ", r)
			pbErr := utils.RecoverToEError(r, pb.EError_EE_API_FAILED)
			errRes = status.Errorf(codes.Internal, "internal server error")
			res = &pb.GetMenuDetailResponse{Success: false, Error: pbErr.Enum()}
		}
	}()

	storeID, err := mstore.ValidateStoreCodeAndGetObjectID(req.StoreCode)
	if err != nil {
		panic(pb.EError_EE_STORE_NOT_FOUND)
	}

	mMenu, err := mmenu.GetMMenuDetail(storeID, req.Category, req.Name)
	if err != nil {
		panic(fmt.Errorf("failed to get mStore: %v", err))
	}

	if mMenu == nil {
		return &pb.GetMenuDetailResponse{
			Success: false,
			Error:   pb.EError_EE_API_FAILED.Enum(),
		}, status.Errorf(codes.NotFound, "menu not found: %s", req.Name)
	}

	var options []*pb.Option
	for _, opt := range mMenu.Options {
		options = append(options, &pb.Option{
			Type:        opt.Type,
			Choices:     opt.Choices,
			OptionPrice: opt.OptionPrice,
		})
	}
	return &pb.GetMenuDetailResponse{
		Success: true,
		Menu: &pb.ViewMenuDetail{
			Category:         mMenu.Category,
			Name:             mMenu.Name,
			MenuPrice:        mMenu.MenuPrice,
			Image:            mMenu.Image,
			SignLanguageUrls: mMenu.SignLanguageURLs,
			Options:          options,
		},
	}, nil
}

func toViewMenu(m *dbstructure.MMenu) *pb.ViewMenu {
	return &pb.ViewMenu{
		Category:  m.Category,
		Name:      m.Name,
		MenuPrice: m.MenuPrice,
		Image:     m.Image,
	}
}

func toMOptions(pbOptions []*pb.Option) []dbstructure.MOption {
	var options []dbstructure.MOption
	for _, opt := range pbOptions {
		options = append(options, dbstructure.MOption{
			Type:        opt.Type,
			Choices:     opt.Choices,
			OptionPrice: opt.OptionPrice,
		})
	}
	return options
}
