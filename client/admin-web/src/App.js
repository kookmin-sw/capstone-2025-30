import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import LoginPage from "@/pages/LoginPage";
import OrderListPage from "@/pages/OrderListPage";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LoginPage />} />
        <Route path="/order-list" element={<OrderListPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
