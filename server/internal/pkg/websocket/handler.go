package websocketHandler

import (
	"github.com/gorilla/websocket"
	"github.com/sirupsen/logrus"
	"net/http"
	"os"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func WebSocketHandler(w http.ResponseWriter, r *http.Request) {
	// 0. api key ckeck
	apiKey := r.Header.Get("api_key")
	if apiKey != os.Getenv("WEBSOCKET_API_KEY") {
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		logrus.Errorln("Unauthorized, invalid websocket api key")
		return
	}

	// 1. Http -> WebSocket Upgrade
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		logrus.Errorln("Websocket upgrade error:", err)
		return
	}
	defer conn.Close()

	logrus.Infof("Client connected: %s", conn.RemoteAddr())

	// 2. Message loop
	for {
		messageType, msg, err := conn.ReadMessage()
		if err != nil {
			logrus.Errorln("Message read error:", err)
			break
		}

		logrus.Infof("Message received: %s", string(msg))

		// 3. Echo back
		if err := conn.WriteMessage(messageType, msg); err != nil {
			logrus.Errorln("Message write error:", err)
			break
		}
	}
}
