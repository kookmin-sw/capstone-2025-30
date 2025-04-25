package dbstructure

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type MNotificationMessage struct {
	ID        primitive.ObjectID `bson:"_id"`
	StoreCode primitive.ObjectID `bson:"store_code"` // 가게 obejct id
	Title     string             `bson:"title"`      // order, inquiry
	Number    int                `bson:"number"`     // 주문번호나 문의번호
	Accepted  bool               `bson:"accepted"`   // 접수 여부, true : 접수, false : 미접수
	Deleted   bool               `bson:"deleted"`    // 삭제 여부, true : 삭제, false : 미삭제
	CreatedAt time.Time          `bson:"created_at"` // 메세지 생성 시간
	UpdatedAt time.Time          `bson:"updated_at"` // cron 으로 삭제하기 위한 updated_at -> deleted 로 바뀌면 시간 업데이트
}

type MMessage struct {
	ID        primitive.ObjectID `bson:"_id"`
	StoreId   primitive.ObjectID `bson:"store_id"`
	Title     string             `bson:"title"`      // orderMessage(주문, 주문 추가 문의사항), inquiryMessage(일반 문의사항)
	Number    int32              `bson:"number"`     // 주문번호나 문의번호
	Accepted  bool               `bson:"accepted"`   // 접수 여부, true : 접수, false : 미접수
	Deleted   bool               `bson:"deleted"`    // 삭제 여부, true : 삭제, false : 미삭제
	CreatedAt time.Time          `bson:"created_at"` // 메세지 생성 시간
	UpdatedAt time.Time          `bson:"updated_at"` // cron 으로 삭제하기 위한 updated_at -> deleted 로 바뀌면 시간 업데이트
	Message   string             `bson:"message"`    // 전송한 메세지
}
