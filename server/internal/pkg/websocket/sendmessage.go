package websocketHandler

import (
	"encoding/json"
	"fmt"

	"github.com/gorilla/websocket"
)

func SendMessageToClient(client_id string, message WebSocketMessage) error {
	WebSocketClientsMutex.RLock()
	conn, ok := WebSocketClients[client_id]
	WebSocketClientsMutex.RUnlock()

	if !ok {
		return fmt.Errorf("client not found: %s", client_id)
	}

	messageJSON, err := json.Marshal(message)
	if err != nil {
		return fmt.Errorf("failed to marshal message: %v", err)
	}

	return conn.WriteMessage(websocket.TextMessage, messageJSON)
}

type WebSocketMessage struct {
	Type string      `json:"type"` //notification, orderMessage, inquryMessage
	Data interface{} `json:"data"`
}

type NotificationData struct {
	Title string `json:"title"` // order, inquiry
	Num   int    `json:"num"`
}

type MessageData struct {
	Num       int    `json:"num"`
	Message   string `json:"message"`
	CreatedAt string `json:"created_at"`
}
