import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import HomePage from "@/pages/HomePage";
import CategoryPage from "@/pages/CategoryPage";
import MenuPage from "@/pages/MenuPage";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/category" element={<CategoryPage />} />
        <Route path="/menu/:categoryKey" element={<MenuPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
