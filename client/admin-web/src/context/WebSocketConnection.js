import { useEffect, useRef, useState } from "react";

const useWebSocket = () => {
  const ws = useRef(null);
  const [isConnected, setIsConnected] = useState(false);
  const [messages, setMessages] = useState([]);
  const WS_URL = `${process.env.REACT_APP_WS_URL}?store_code=5fjVwE8z&client_type=manager_web&api-key=${process.env.REACT_APP_WS_API_KEY}`;

  useEffect(() => {
    connectWebSocket();

    return () => {
      if (ws.current) {
        disconnectWebSocket();
      }
    };
  }, []);

  const connectWebSocket = () => {
    console.log("websocket 연결 시도 URL:", WS_URL);

    try {
      ws.current = new WebSocket(WS_URL);

      ws.current.onopen = () => {
        console.log("websocket 연결됨");
        setIsConnected(true);
      };

      ws.current.onmessage = (event) => {
        console.log("메시지 수신:", event.data);
        setMessages((prev) => [...prev, event.data]);
      };

      ws.current.onerror = (error) => {
        console.error("websocket 오류:", error);
        setIsConnected(false);
      };

      ws.current.onclose = (event) => {
        console.warn("websocket 닫힘:", event);
        setIsConnected(false);
      };
    } catch (err) {
      console.error("websocket 예외 발생:", err);
    }
  };

  const disconnectWebSocket = () => {
    if (ws.current) {
      ws.current.close();
      setIsConnected(false);
    }
  };

  const sendMessage = (message) => {
    if (ws.current && ws.current.readyState === WebSocket.OPEN) {
      ws.current.send(JSON.stringify(message));
    } else {
      console.log("websocket 확인 필요");
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

export default useWebSocket;
