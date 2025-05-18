import { useEffect, useRef, useState } from "react";

const useWebSocketConnection = () => {
  const ws = useRef(null);
  const [isConnected, setIsConnected] = useState(false);
  const [messages, setMessages] = useState([]);
  const WS_URL = `${process.env.REACT_APP_WS_URL}?store_code=5fjVwE8z&client_type=manager_web&api-key=${process.env.REACT_APP_WS_API_KEY}`;
  const hasConnectedOnce = useRef(false);
  const reconnectDelay = 2000;
  const reconnectTimer = useRef(null);
  const isReconnecting = useRef(false);

  useEffect(() => {
    console.log("useEffect: websocket 연결 시도");
    connectWebSocket();

    return () => {
      if (reconnectTimer.current) {
        clearTimeout(reconnectTimer.current);
      }

      // StrictMode 대응: 연결된 적 있고 실제로 열린 상태일 때만 disconnect
      if (
        ws.current &&
        (ws.current.readyState === WebSocket.OPEN ||
          ws.current.readyState === WebSocket.CONNECTING) &&
        hasConnectedOnce.current
      ) {
        console.log("useEffect 정리: websocket 연결 해제 시도");
        disconnectWebSocket();
      } else {
        console.log("useEffect 정리: websocket 연결 전이라 해제 생략");
      }
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const connectWebSocket = () => {
    try {
      ws.current = new WebSocket(WS_URL);

      ws.current.onopen = () => {
        console.log("websocket 연결됨");
        setIsConnected(true);
        hasConnectedOnce.current = true;
      };

      ws.current.onmessage = (event) => {
        console.log("메시지 수신:", event.data);
        setMessages((prev) => [...prev, event.data]);
      };

      ws.current.onerror = (error) => {
        console.error("websocket 오류:", error);
        setIsConnected(false);
        reconnect();
      };

      ws.current.onclose = (event) => {
        console.warn(
          "websocket 닫힘 - 코드:",
          event.code,
          "이유:",
          event.reason,
          "정상적으로 종료되었는지 여부(true면 의도적인 종료):",
          event.wasClean
        );
        setIsConnected(false);
        reconnect();
      };
    } catch (err) {
      console.error("websocket 예외 발생:", err);
    }
  };

  const disconnectWebSocket = () => {
    if (ws.current) {
      console.log("websocket 연결 종료 시도");
      ws.current.close();
      setIsConnected(false);
    }
  };

  const reconnect = () => {
    if (isReconnecting.current) return;

    isReconnecting.current = true;
    console.warn(`웹소켓 재연결을 ${reconnectDelay / 1000}초 후 시도합니다`);

    reconnectTimer.current = setTimeout(() => {
      connectWebSocket();
      isReconnecting.current = false;
    }, reconnectDelay);
  };

  const sendMessage = (message) => {
    if (ws.current && ws.current.readyState === WebSocket.OPEN) {
      ws.current.send(JSON.stringify(message));
      console.log("메시지 전송:", message);
    } else {
      console.warn("websocket 열려 있지 않음. 전송 실패.");
    }
  };

  return {
    ws,
    isConnected,
    messages,
    sendMessage,
    connectWebSocket,
    disconnectWebSocket,
  };
};

export default useWebSocketConnection;
