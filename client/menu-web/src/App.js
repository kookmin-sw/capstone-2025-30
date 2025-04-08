import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import HomePage from "@/pages/HomePage";
import CategoryPage from "@/pages/CategoryPage";
import MenuPage from "@/pages/MenuPage";
import DetailedMenuPage from "@/pages/DetailedMenuPage";
import ShoppingCartPage from "@/pages/ShoppingCartPage";
import OrderNumberPage from "@/pages/OrderNumberPage";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/category" element={<CategoryPage />} />
        <Route path="/menu/:categoryKey" element={<MenuPage />} />
        <Route
          path="/detailed-menu/:categoryKey/:id"
          element={<DetailedMenuPage />}
        />
        <Route path="/shopping-cart" element={<ShoppingCartPage />} />
        <Route path="/order-number" element={<OrderNumberPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
