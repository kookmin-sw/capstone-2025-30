import React from "react";
import CustomStyles from "@/styles/CustomStyles";

const ButtonTemperature = ({ icon, text, isSelected, onClick }) => {
  const styles = {
    containerSelect: {
      display: "flex",
      flexDirection: "column",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: 24,
      width: "100%",
      height: 72,
      margin: "0 5px 0 5px",
      border: "none",
      backgroundColor: isSelected
        ? CustomStyles.primaryBlue
        : CustomStyles.primaryGray,
      color: isSelected ? CustomStyles.primaryWhite : CustomStyles.pointGray,
    },
    textSelect: {
      ...CustomStyles.fontHead16,
    },
  };

  return (
    <button onClick={onClick} style={{ ...styles.containerSelect }}>
      <div style={{ margin: "2px 0" }}>{icon}</div>
      <div style={{ ...styles.textSelect }}>{text}</div>
    </button>
  );
};

export default ButtonTemperature;
