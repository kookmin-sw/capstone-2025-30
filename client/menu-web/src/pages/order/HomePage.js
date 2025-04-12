import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import HomeStyles from "@/pages/order/HomeStyles";

const OrderButton = ({ icon, text, to }) => {
  const [isPressed, setIsPressed] = useState(false);
  const navigate = useNavigate();

  const handlePressIn = () => setIsPressed(true);
  const handlePressOut = () => setIsPressed(false);
  const handleClick = () => navigate(to);

  return (
    <button
      onMouseDown={handlePressIn}
      onMouseUp={handlePressOut}
      onMouseLeave={handlePressOut}
      onTouchStart={handlePressIn}
      onTouchEnd={handlePressOut}
      onClick={handleClick}
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
  return (
    <div>
      <p style={{ ...HomeStyles.headerIcon }}>🏠</p>
      <div style={{ ...HomeStyles.container }}>
        <OrderButton icon="📋" text="주문하기" to="/category" />
        <OrderButton
          icon="✅"
          text={
            <>
              주문 상태
              <br />
              확인하기
            </>
          }
          to="/check-order-number"
        />
      </div>
    </div>
  );
};

export default HomePage;
