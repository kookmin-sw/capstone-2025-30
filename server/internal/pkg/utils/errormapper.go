package utils

import (
	"net/http"
	pb "server/gen"
)

func HTTPStatusFromEError(e pb.EError) int {
	switch e {
	case pb.EError_EE_API_AUTH_FAILED:
		return http.StatusUnauthorized
	case pb.EError_EE_INVALID_ARGUMENT:
		return http.StatusBadRequest
	case pb.EError_EE_STORE_ALREADY_EXISTS,
		pb.EError_EE_MENU_ALREADY_EXISTS:
		return http.StatusConflict
	case pb.EError_EE_STORE_NOT_FOUND,
		pb.EError_EE_MENU_NOT_FOUND,
		pb.EError_EE_ORDER_NOT_FOUND:
		return http.StatusNotFound
	case pb.EError_EE_STORE_UPDATE_NO_FIELDS:
		return http.StatusBadRequest
	default:
		return http.StatusInternalServerError
	}
}
