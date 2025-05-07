package websocketHandler

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	mstore "server/internal/pkg/database/mongodb/store"
	"server/internal/pkg/utils"
	"sync"

	"github.com/gorilla/websocket"
	"github.com/sirupsen/logrus"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

var (
	WebSocketClients      = make(map[string]*websocket.Conn)
	WebSocketClientsMutex sync.RWMutex
)

func WebSocketHandler(w http.ResponseWriter, r *http.Request) {
	// 0. api key ckeck & Authorization
	// 0.1 api key check
	apiKey := r.URL.Query().Get("api-key")

	if apiKey != os.Getenv("WEBSOCKET_API_KEY") {
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		logrus.Errorln("Unauthorized, invalid websocket api key")
		return
	}

	// 0.2 Authorization
	store_code := r.URL.Query().Get("store_code")
	//userId is valid func 만들어서 check -> userId db 에서 확인 후 없으면 invaild
	_, err := mstore.ValidateStoreCodeAndGetObjectID(store_code)
	if err != nil {
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		logrus.Errorln("Unauthorized, invalid client_id")
		return
	}

	client_type := r.URL.Query().Get("client_type")
	if client_type != utils.WebSocketClientTypeCounterApp && client_type != utils.WebSocketClientTypeManagerWeb {
		http.Error(w, "Invalid client type", http.StatusBadRequest)
		logrus.Errorln("Invalid client type")
		return
	}

	// 1. Http -> WebSocket Upgrade
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		logrus.Errorln("Websocket upgrade error:", err)
		return
	}
	defer conn.Close()

	// 2. make connection name
	connectionName := fmt.Sprintf("%s_%s", store_code, client_type)

	// 3. connection save
	WebSocketClientsMutex.Lock()
	WebSocketClients[connectionName] = conn
	WebSocketClientsMutex.Unlock()
	defer func() {
		WebSocketClientsMutex.Lock()
		delete(WebSocketClients, connectionName)
		WebSocketClientsMutex.Unlock()
	}()

	logrus.Infof("Client connected save: %s (%s)", conn.RemoteAddr(), connectionName)

	// 4. message read
	for {
		_, msg, err := conn.ReadMessage()
		if err != nil {
			logrus.Errorln("Message read error:", err)
			break
		}

		logrus.Infof("Received message: %s", msg)

		// 메세지 처리
		// go func 으로 메세지 db에 저장하는 로직 넣기
		// 테스트 커밋
		// 메시지 파싱
		var wsMsg WebSocketReceiveMessage
		if err := json.Unmarshal(msg, &wsMsg); err != nil {
			logrus.Errorf("Message unmarshal error: %v", err)
			continue
		}

		// 메시지 저장
		if err := ReceiveKoreanMessage(&wsMsg); err != nil {
			logrus.Errorf("Failed to process message: %v", err)
			// 에러 응답을 클라이언트에게 전송
			conn.WriteJSON(map[string]string{
				"error": err.Error(),
			})
			continue
		}

		// 성공 응답
		conn.WriteJSON(map[string]string{
			"status": "success",
		})
	}
}
