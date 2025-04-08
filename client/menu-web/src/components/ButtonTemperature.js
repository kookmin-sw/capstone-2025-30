import React from "react";
import CustomStyles from "../styles/CustomStyles";

const ButtonTemperature = ({ icon, text, isSelected, onClick }) => {
  const styles = {
    containerSelect: {
      display: "flex",
      flexDirection: "column",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: 24,
      width: "100%",
      height: 68,
      margin: "0 5px 0 5px",
      border: "none",
    },
    textSelect: {
      ...CustomStyles.fontCaption,
      fontWeight: 700,
      marginTop: 6,
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
        color: isSelected ? CustomStyles.primaryWhite : CustomStyles.pointGray,
      }}
    >
      {icon}
      <div style={{ ...styles.textSelect }}>{text}</div>
    </button>
  );
};

export default ButtonTemperature;
