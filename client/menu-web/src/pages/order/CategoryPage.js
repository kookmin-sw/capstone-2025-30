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
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A9%94%EB%89%B4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A2%85%EB%A5%98.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%84%A0%ED%83%9D.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%BB%A4%ED%94%BC.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8F%E1%85%A5%E1%84%91%E1%85%B5+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%28%EB%A7%88%EC%8B%9C%EB%8A%94%29%EC%B0%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%92%E1%85%A5%E1%84%87%E1%85%B3+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%BB%A4%ED%94%BC.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%95%84%EB%8B%88%EB%8B%A4%2C%20%EC%95%8A%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%B3%E1%86%B7%E1%84%85%E1%85%AD+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8F%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%8F%E1%85%B3.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8F%E1%85%A6%E1%84%8B%E1%85%B5%E1%84%8F%E1%85%B3+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B9%B5.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%88%E1%85%A1%E1%86%BC+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%91%E1%85%AE%E1%86%AF.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%84%9E%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%A2%E1%86%AF%E1%84%85%E1%85%A5%E1%84%83%E1%85%B3+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
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
