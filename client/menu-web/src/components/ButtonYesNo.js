import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";

import { ReactComponent as IconYes } from "@/assets/icons/yes.svg";
import { ReactComponent as IconNo } from "@/assets/icons/no.svg";

const CommonButton = ({ label, Icon, onPress, style }) => {
  const [isPressed, setIsPressed] = useState(false);

  const handlePressIn = () => setIsPressed(true);
  const handlePressOut = () => {
    setIsPressed(false);
  };

  return (
    <button
      onClick={onPress}
      onMouseDown={handlePressIn}
      onMouseUp={handlePressOut}
      onMouseLeave={handlePressOut}
      onTouchStart={handlePressIn}
      onTouchEnd={handlePressOut}
      style={{
        display: "flex",
        flexDirection: "column",
        justifyContent: "center",
        alignItems: "center",
        borderRadius: 24,
        width: "100%",
        height: 84,
        border: "none",
        backgroundColor: isPressed
          ? CustomStyles.primaryBlue
          : CustomStyles.primaryGray,
        color: isPressed ? CustomStyles.primaryWhite : CustomStyles.pointGray,
        ...style,
      }}
    >
      <Icon />
      <div
        style={{
          ...CustomStyles.fontCaption,
          fontWeight: 700,
          marginTop: 6,
        }}
      >
        {label}
      </div>
    </button>
  );
};

const ButtonYesNo = ({ pressNo }) => {
  const navigate = useNavigate();

  return (
    <div style={{ display: "flex" }}>
      <CommonButton
        label="예"
        Icon={IconYes}
        style={{ marginRight: 12 }}
        onPress={() => navigate("/order-number")}
      />
      <CommonButton
        label="아니오"
        Icon={IconNo}
        style={{ marginLeft: 12 }}
        onPress={pressNo}
      />
    </div>
  );
};

export default ButtonYesNo;
