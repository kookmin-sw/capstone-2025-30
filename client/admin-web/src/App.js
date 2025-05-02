import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import LoginPage from "@/pages/LoginPage";
import OrderListPage from "@/pages/OrderListPage";
import ChatOrderPage from "@/pages/ChatOrderPage";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LoginPage />} />
        <Route path="/order-list" element={<OrderListPage />} />
        <Route path="/chat-order" element={<ChatOrderPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
