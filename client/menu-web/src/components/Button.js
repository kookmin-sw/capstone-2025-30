import React from "react";
import CustomStyles from "../styles/CustomStyles";

const Button = ({ icon, text, onClick }) => {
  const styles = {
    button: {
      ...CustomStyles.fontHead24,
      width: "100%",
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      padding: "15px",
      backgroundColor: CustomStyles.primaryBlue,
      color: CustomStyles.primaryWhite,
      borderRadius: 32,
      cursor: "pointer",
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
