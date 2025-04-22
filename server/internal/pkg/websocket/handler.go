package websocketHandler

import (
	"github.com/gorilla/websocket"
	"github.com/sirupsen/logrus"
	"net/http"
	"os"
	mstore "server/internal/pkg/database/mongodb/store"
	"sync"
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
	apiKey := r.Header.Get("api-key")

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

	// 1. Http -> WebSocket Upgrade
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		logrus.Errorln("Websocket upgrade error:", err)
		return
	}
	defer conn.Close()

	// 3. connection save
	WebSocketClientsMutex.Lock()
	WebSocketClients[store_code] = conn
	WebSocketClientsMutex.Unlock()
	defer func() {
		WebSocketClientsMutex.Lock()
		delete(WebSocketClients, store_code)
		WebSocketClientsMutex.Unlock()
	}()

	logrus.Infof("Client connected save: %s (%s)", conn.RemoteAddr(), store_code)

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
	}
}
