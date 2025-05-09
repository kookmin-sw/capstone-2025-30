import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import HomeStyles from "@/pages/order/HomeStyles";

import SignVideo from "@/components/SignVideo";

const OrderButton = ({ icon, text, onClick }) => {
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
      onClick={onClick}
      style={{
        ...HomeStyles.orderButton,
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
          fontSize: 80,
          lineHeight: "80px",
          marginBottom: 20,
        }}
      >
        {icon}
      </span>
      {text}
    </button>
  );
};

const HomePage = () => {
  const navigate = useNavigate();

  const videos = [
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/안녕하세요%2C안녕히%20가십시오.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A3%BC%EB%AC%B8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%B8%E1%84%87%E1%85%A9%E1%84%83%E1%85%B3+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A3%BC%EB%AC%B8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%83%81%ED%83%9C%2C%20%EC%83%81%ED%99%A9.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%82%B4%ED%8E%B4%EB%B3%B4%EB%8B%A4%2C%EC%82%B4%ED%94%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%92%E1%85%AA%E1%86%A8%E1%84%8B%E1%85%B5%E1%86%AB+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
  ];

  return (
    <>
      <p style={HomeStyles.headerIcon}>🏠</p>
      <div style={HomeStyles.container}>
        <SignVideo srcList={videos} />
        <div style={HomeStyles.containerButton}>
          <div style={{ flex: 1, marginRight: "3%" }}>
            <OrderButton
              icon="📋"
              text="주문하기"
              onClick={() => navigate("/category")}
            />
          </div>
          <div style={{ flex: 1, marginLeft: "3%" }}>
            <OrderButton
              icon="✅"
              text={<>주문 상태 확인</>}
              onClick={() => navigate("/check-order-number")}
            />
          </div>
        </div>
      </div>
    </>
  );
};

export default HomePage;
