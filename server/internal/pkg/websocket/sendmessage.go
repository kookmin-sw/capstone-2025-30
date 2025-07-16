package websocketHandler

import (
	"encoding/json"
	"fmt"
	"time"

	"github.com/gorilla/websocket"
)

func SendMessageToClient(store_code string, message WebSocketMessage, client_type string) error {
	connectionName := fmt.Sprintf("%s_%s", store_code, client_type)

	WebSocketClientsMutex.RLock()
	conn, ok := WebSocketClients[connectionName]
	WebSocketClientsMutex.RUnlock()

	if !ok {
		return fmt.Errorf("client not found: %s", connectionName)
	}

	messageJSON, err := json.Marshal(message)
	if err != nil {
		return fmt.Errorf("failed to marshal message: %v", err)
	}

	return conn.WriteMessage(websocket.TextMessage, messageJSON)
}

type WebSocketMessage struct {
	Type string      `json:"type"` //notification, orderMessage, inquiryMessage, signMessage
	Data interface{} `json:"data"`
}

type NotificationData struct {
	Title string `json:"title"` // order, inquiry
	Num   int    `json:"num"`
}

type MessageData struct {
	Num       int32     `json:"num"`
	Message   string    `json:"message"`
	CreatedAt time.Time `json:"created_at"`
}

type SignUrlData struct {
	SignUrls []string `json:"sign_urls"`
}

// 배포용 로그
