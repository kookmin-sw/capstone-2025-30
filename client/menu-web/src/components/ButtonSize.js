import React from "react";
import CustomStyles from "../styles/CustomStyles";

const ButtonSize = ({ size, icon, text, isSelected, onClick }) => {
  const styles = {
    containerSelect: {
      position: "relative",
      display: "flex",
      flexDirection: "column",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: 24,
      width: "100%",
      height: 100,
      margin: "15px 5px 70px 5px",
      border: "none",
    },
    textSelect: {
      ...CustomStyles.fontCaption,
      fontWeight: 700,
      marginTop: 6,
    },
    textSize: {
      ...CustomStyles.fontSub16,
      fontWeight: "bold",
      position: "absolute",
      left: "50%",
      transform: "translateX(-50%)",
      marginBottom: 10,
    },
  };

  return (
    <button
      onClick={onClick}
      style={{
        ...styles.containerSelect,
        backgroundColor: isSelected
          ? CustomStyles.primaryBlue
          : CustomStyles.primaryGray,
        color: isSelected ? CustomStyles.pointBlue : CustomStyles.pointGray,
      }}
    >
      <div
        style={{
          ...styles.textSize,
          color: CustomStyles.pointGray,
        }}
      >
        {size}
      </div>
      {icon}
      <div
        style={{
          ...styles.textSelect,
          color: isSelected
            ? CustomStyles.primaryWhite
            : CustomStyles.pointGray,
        }}
      >
        {text}
      </div>
    </button>
  );
};

export default ButtonSize;
