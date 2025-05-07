import React from "react";
import CustomStyles from "@/styles/CustomStyles";

const Button = ({ icon, text, disabled = false, onClick }) => {
  const styles = {
    button: {
      ...CustomStyles.fontHead24,
      width: "100%",
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      padding: "15px",
      backgroundColor: disabled
        ? CustomStyles.primaryGray
        : CustomStyles.primaryBlue,
      color: disabled ? CustomStyles.pointGray : CustomStyles.primaryWhite,
      borderRadius: 32,
      cursor: disabled ? "none" : "pointer",
      marginBottom: 50,
      border: "none",
    },
  };

  return (
    <button style={{ ...styles.button }} onClick={onClick}>
      <div style={{ marginRight: 20 }}>{icon}</div>
      {text}
    </button>
  );
};

export default Button;
