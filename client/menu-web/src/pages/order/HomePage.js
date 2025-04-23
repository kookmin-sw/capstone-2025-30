import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import HomeStyles from "@/pages/order/HomeStyles";

import { useCart } from "../../context/CartContext";
import BottomSheet from "@/components/BottomSheet";
import ButtonYesNo from "@/components/ButtonYesNo";

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
  const { setIsDineIn } = useCart();
  const [isBottomSheetOpen, setIsBottomSheetOpen] = useState(false);

  return (
    <>
      <p style={{ ...HomeStyles.headerIcon }}>🏠</p>
      <div style={{ ...HomeStyles.container }}>
        <OrderButton
          icon="📋"
          text="주문하기"
          onClick={() => setIsBottomSheetOpen(true)}
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

      {isBottomSheetOpen && (
        <BottomSheet onClose={() => setIsBottomSheetOpen(false)}>
          <div
            style={{
              width: "100%",
              paddingTop: "100%",
              backgroundColor: "#D0D0D0",
              borderRadius: 16,
            }}
          />
          <div style={{ margin: "24px 0 24px 0" }}>
            <ButtonYesNo
              pressYes={() => {
                setIsDineIn(true);
                navigate("/category");
              }}
              pressNo={() => {
                setIsDineIn(false);
                navigate("/category");
              }}
            />
          </div>
        </BottomSheet>
      )}
    </>
  );
};

export default HomePage;
