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
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%A1%E1%84%89%E1%85%A6%E1%84%8B%E1%85%AD%2C%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%B5+%E1%84%80%E1%85%A1%E1%84%89%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%84%8B%E1%85%A9.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%84%86%E1%85%AE%E1%86%AB.mp4",
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
