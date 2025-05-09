import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";

const ButtonMenu = ({ menu, isNull = false }) => {
  const [isPressed, setIsPressed] = useState(false);
  const navigate = useNavigate();

  const handlePressIn = () => {
    if (isNull) return;
    setIsPressed(true);
  };

  const handlePressOut = () => {
    if (isNull) return;
    setIsPressed(false);
  };

  const handleClick = () => {
    if (isNull) return;
    navigate(`/detailed-menu/${menu.category}/${menu.name}`);
  };

  const styles = {
    menuButton: {
      ...CustomStyles.fontSub16,
      position: "relative",
      overflow: "hidden",
      display: "flex",
      justifyContent: "center",
      alignItems: "flex-end",
      width: 140,
      height: 164,
      backgroundSize: "cover",
      backgroundRepeat: "no-repeat",
      backgroundPosition: "center",
      color: CustomStyles.primaryBlack,
      borderRadius: 16,
      border: "none",
      cursor: isNull ? "default" : "pointer",
    },
    menuButtonTextContainer: {
      position: "absolute",
      left: 0,
      right: 0,
      bottom: 0,
      width: "100%",
      height: "30%",
      backgroundColor: CustomStyles.primaryBlue,
      color: CustomStyles.primaryWhite,
      display: "flex",
      flexDirection: "column",
      justifyContent: "center",
      alignItems: "center",
    },
    textMenu: {
      ...CustomStyles.fontSub16,
      whiteSpace: "nowrap",
      overflow: "hidden",
      textOverflow: "ellipsis",
      maxWidth: "132px",
    },
  };

  return (
    <button
      onMouseDown={handlePressIn}
      onMouseUp={handlePressOut}
      onMouseLeave={handlePressOut}
      onTouchStart={handlePressIn}
      onTouchEnd={handlePressOut}
      onClick={handleClick}
      style={{
        ...styles.menuButton,
        backgroundColor: isPressed
          ? CustomStyles.primaryBlue
          : CustomStyles.primaryGray,
        color: isPressed
          ? CustomStyles.primaryWhite
          : CustomStyles.primaryBlack,
        backgroundImage: `url(${menu.image})`,
      }}
    >
      <div
        style={{
          ...styles.menuButtonTextContainer,
          backgroundColor: isPressed
            ? CustomStyles.primaryBlue
            : CustomStyles.primaryGray,
          color: isPressed
            ? CustomStyles.primaryWhite
            : CustomStyles.primaryBlack,
        }}
      >
        <div style={{ ...styles.textMenu, fontWeight: 700 }}>{menu.name}</div>
        <div style={{ ...styles.textMenu }}>
          {menu.menu_price ? menu.menu_price : menu.item_price}원
        </div>
      </div>
    </button>
  );
};

export default ButtonMenu;
