package websocketHandler

import (
	"fmt"
	"github.com/gorilla/websocket"
)

func SendMessageToClient(client_id, message string) error {
	WebSocketClientsMutex.RLocker()
	conn, ok := WebSocketClients[client_id]
	WebSocketClientsMutex.RUnlock()

	if !ok {
		return fmt.Errorf("client not found: %s", client_id)
	}

	return conn.WriteMessage(websocket.TextMessage, []byte(message))
}
