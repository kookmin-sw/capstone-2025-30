import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import CategoryStyles from "@/pages/order/CategoryStyles";

import { getCategory } from "../../config/api";
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
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    const fetchGetCategory = async () => {
      try {
        const category = await getCategory();
        setCategories(category.data.categories);
      } catch (error) {
        console.error(
          "카테고리 조회 오류:",
          error.response ? error.response.data : error.message
        );
      }
    };
    fetchGetCategory();
  }, []);

  const category = [
    { icon: "☕️", text: categories[2], to: `/menu/${categories[2]}` },
    { icon: "🌿", text: categories[1], to: `/menu/${categories[1]}` },
    { icon: "🧋", text: categories[0], to: `/menu/${categories[0]}` },
    { icon: "🍰", text: "케이크", to: "/menu/케이크" },
    { icon: "🥯", text: "빵", to: "/menu/빵" },
    { icon: "🥗", text: "샐러드", to: "/menu/샐러드" },
  ];

  return (
    <div>
      <Header centerIcon="📋" />
      <div style={{ ...CategoryStyles.container }}>
        {category.map((item, idx) => (
          <CategoryButton key={idx} category={item} />
        ))}
      </div>
    </div>
  );
};

export default CategoryPage;
