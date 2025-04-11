import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import CategoryStyles from "@/pages/order/CategoryStyles";

import Header from "@/components/Header";

const CategoryButton = ({ category }) => {
  const [isPressed, setIsPressed] = useState(false);
  const navigate = useNavigate();

  const handlePressIn = () => setIsPressed(true);
  const handlePressOut = () => setIsPressed(false);
  const handleClick = () => navigate(category.to);

  return (
    <button
      onMouseDown={handlePressIn}
      onMouseUp={handlePressOut}
      onMouseLeave={handlePressOut}
      onTouchStart={handlePressIn}
      onTouchEnd={handlePressOut}
      onClick={handleClick}
      style={{
        ...CategoryStyles.categoryButton,
        backgroundColor: isPressed
          ? CustomStyles.primaryBlue
          : CustomStyles.primaryGray,
        color: isPressed
          ? CustomStyles.primaryWhite
          : CustomStyles.primaryBlack,
      }}
    >
      <span
        style={{
          display: "block",
          fontSize: 60,
          lineHeight: "68px",
          marginBottom: 10,
        }}
      >
        {category.icon}
      </span>
      {category.text}
    </button>
  );
};

const CategoryPage = () => {
  const category = [
    { icon: "☕️", text: "커피", to: "/menu/coffee" },
    { icon: "🌿", text: "차", to: "/menu/tea" },
    { icon: "🧋", text: "음료", to: "/menu/drink" },
    { icon: "🍰", text: "케이크", to: "/menu/cake" },
    { icon: "🥯", text: "빵", to: "/menu/bread" },
    { icon: "🥗", text: "샐러드", to: "/menu/salad" },
  ];

  return (
    <div>
      <Header centerIcon="📋" />
      <div style={{ ...CategoryStyles.container }}>
        {category.map((category, idx) => (
          <CategoryButton key={idx} category={category} />
        ))}
      </div>
    </div>
  );
};

export default CategoryPage;
