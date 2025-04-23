import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import { CartProvider } from "./context/CartContext";

import HomePage from "@/pages/order/HomePage";
import CategoryPage from "@/pages/order/CategoryPage";
import MenuPage from "@/pages/order/MenuPage";
import DetailedMenuPage from "@/pages/order/DetailedMenuPage";
import ShoppingCartPage from "@/pages/order/ShoppingCartPage";
import OrderNumberPage from "@/pages/order/OrderNumberPage";
import OrderProcessPage from "@/pages/checkOrder/OrderProcessPage";
import CheckOrderNumberPage from "@/pages/checkOrder/CheckOrderNumberPage";

function App() {
  return (
    <BrowserRouter>
      <CartProvider>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/category" element={<CategoryPage />} />
          <Route path="/menu/:categoryPath" element={<MenuPage />} />
          <Route
            path="/detailed-menu/:categoryPath/:menuPath"
            element={<DetailedMenuPage />}
          />
          <Route path="/shopping-cart" element={<ShoppingCartPage />} />
          <Route path="/order-number" element={<OrderNumberPage />} />
          <Route
            path="/check-order-number"
            element={<CheckOrderNumberPage />}
          />
          <Route path="/order-process" element={<OrderProcessPage />} />
        </Routes>
      </CartProvider>
    </BrowserRouter>
  );
}

export default App;
