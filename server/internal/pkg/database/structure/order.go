package dbstructure

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	pb "server/gen"
	"time"
)

// 옵션 선택
type MItemOptions map[string]string

// 주문 항목
type MOrderItem struct {
	Name      string       `bson:"name" json:"Name"`
	Image     string       `bson:"image" json:"Image"`
	Options   MItemOptions `bson:"options" json:"Options"`
	Quantity  int32        `bson:"quantity" json:"Quantity"`
	ItemPrice int32        `bson:"item_price" json:"ItemPrice"`
}

// 주문 전체
type MOrder struct {
	ID          primitive.ObjectID `bson:"_id,omitempty" json:"ID"`
	StoreID     primitive.ObjectID `bson:"store_id" json:"StoreID"`
	StoreCode   string             `bson:"store_code" json:"StoreCode"`
	OrderNumber int32              `bson:"order_number" json:"OrderNumber"`
	DineIn      bool               `bson:"dine_in" json:"DineIn"`
	Status      pb.OrderStatus     `bson:"status" json:"Status"` //ORDER_PENDING 기본
	Items       []MOrderItem       `bson:"items" json:"items"`
	TotalPrice  int32              `bson:"total_price" json:"total_price"`
	CreatedAt   time.Time          `bson:"created_at" json:"created_at"`
	UpdatedAt   time.Time          `bson:"updated_at" json:"updated_at"`
}
