import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import HomeStyles from "@/pages/order/HomeStyles";
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

  return (
    <>
      <p style={{ ...HomeStyles.headerIcon }}>🏠</p>
      <div style={{ ...HomeStyles.container }}>
        <OrderButton
          icon="📋"
          text="주문하기"
          onClick={() => navigate("/category")}
        />
        <OrderButton
          icon="✅"
          text={
            <>
              주문 상태
              <br />
              확인하기
            </>
          }
          onClick={() => navigate("/check-order-number")}
        />
      </div>
    </>
  );
};

export default HomePage;
