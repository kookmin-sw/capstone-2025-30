package websocketHandler

import (
	"encoding/json"
	"fmt"
	"time"

	"github.com/gorilla/websocket"
)

func SendMessageToClient(store_code string, message WebSocketMessage) error {
	WebSocketClientsMutex.RLock()
	conn, ok := WebSocketClients[store_code]
	WebSocketClientsMutex.RUnlock()

	if !ok {
		return fmt.Errorf("client not found: %s", store_code)
	}

	messageJSON, err := json.Marshal(message)
	if err != nil {
		return fmt.Errorf("failed to marshal message: %v", err)
	}

	return conn.WriteMessage(websocket.TextMessage, messageJSON)
}

type WebSocketMessage struct {
	Type string      `json:"type"` //notification, orderMessage, inquiryMessage
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
