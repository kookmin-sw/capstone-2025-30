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
    if (ws.current && ws.current.readyState === WebSocket.OPEN) return;

    ws.current = new WebSocket(WS_URL);

    ws.current.onopen = () => {
      console.log("websocket 연결");
      setIsConnected(true);
    };

    ws.current.onmessage = (event) => {
      // console.log(event.data);
      setMessages((prev) => [...prev, event.data]);
    };

    ws.current.onclose = (event) => {
      if (ws.current.readyState === WebSocket.OPEN) {
        console.log("실제 연결 살아있음");
        return;
      }
      // console.log("websocket 종료");
      // setIsConnected(false);
    };

    ws.current.onerror = (error) => {
      console.error("websocket 오류:", error);
      setIsConnected(false);
    };
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
