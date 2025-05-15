import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

import { WebSocketProvider } from "./context/WebSocketProvider";
import LoginPage from "@/pages/LoginPage";
import OrderListPage from "@/pages/OrderListPage";
import ChatOrderPage from "@/pages/ChatOrderPage";

function App() {
  return (
    <>
      <WebSocketProvider>
        <ToastContainer />
        <BrowserRouter>
          <Routes>
            <Route path="/" element={<LoginPage />} />
            <Route path="/order-list" element={<OrderListPage />} />
            <Route path="/chat-order" element={<ChatOrderPage />} />
          </Routes>
        </BrowserRouter>
      </WebSocketProvider>
    </>
  );
}

export default App;
