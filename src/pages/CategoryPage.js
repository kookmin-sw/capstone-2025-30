import React, { useState } from "react";

import CustomStyles from "@/styles/CustomStyles";
import CategoryStyles from "@/pages/CategoryStyles";

import Header from "@/components/Header";

const CategoryButton = ({ icon, text }) => {
  const [isPressed, setIsPressed] = useState(false);

  const handlePressIn = () => setIsPressed(true);
  const handlePressOut = () => setIsPressed(false);

  return (
    <button
      onMouseDown={handlePressIn}
      onMouseUp={handlePressOut}
      onMouseLeave={handlePressOut}
      onTouchStart={handlePressIn}
      onTouchEnd={handlePressOut}
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
        {icon}
      </span>
      {text}
    </button>
  );
};

const CategoryPage = () => {
  return (
    <div>
      <Header centerIcon="📋" />
      <div style={{ ...CategoryStyles.container }}>
        <CategoryButton icon="☕️" text="커피" />
        <CategoryButton icon="🌿" text="차" />
        <CategoryButton icon="🧋" text="음료" />
        <CategoryButton icon="🍰" text="케이크" />
        <CategoryButton icon="🥯" text="빵" />
        <CategoryButton icon="🥗" text="샐러드" />
      </div>
    </div>
  );
};

export default CategoryPage;
