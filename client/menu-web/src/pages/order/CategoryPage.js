import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import CategoryStyles from "@/pages/order/CategoryStyles";

import { getCategory } from "../../config/api";
import Header from "@/components/Header";
import SignVideo from "@/components/SignVideo";

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
          fontSize: 52,
          lineHeight: "60px",
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
  ];

  const videos = [
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%A1%E1%84%89%E1%85%A6%E1%84%8B%E1%85%AD%2C%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%B5+%E1%84%80%E1%85%A1%E1%84%89%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%84%8B%E1%85%A9.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%84%86%E1%85%AE%E1%86%AB.mp4",
  ];

  return (
    <div>
      <Header centerIcon="📋" />
      <div style={CategoryStyles.container}>
        <SignVideo srcList={videos} />
        <div style={CategoryStyles.containerCategory}>
          {category.map((item, idx) => (
            <CategoryButton key={idx} category={item} />
          ))}
        </div>
      </div>
    </div>
  );
};

export default CategoryPage;
