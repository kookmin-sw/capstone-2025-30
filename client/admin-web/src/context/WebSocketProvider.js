import React, { createContext, useContext } from "react";
import useWebSocketConnection from "../context/WebSocketConnection";

const WebSocketContext = createContext(null);

export const WebSocketProvider = ({ children }) => {
  const webSocketData = useWebSocketConnection();

  return (
    <WebSocketContext.Provider value={webSocketData}>
      {children}
    </WebSocketContext.Provider>
  );
};

export const useWebSocket = () => {
  const context = useContext(WebSocketContext);
  if (!context) {
    throw new Error("useWebSocket은 WebSocketProvider 내에서 사용해야 함");
  }
  return context;
};
