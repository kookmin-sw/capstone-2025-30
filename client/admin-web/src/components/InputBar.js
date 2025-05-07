import React, { useState } from "react";
import CustomStyles from "@/styles/CustomStyles";

const InputBar = ({ placeholder, buttonText, onClick }) => {
  const [input, setInput] = useState("");

  const styles = {
    wrapper: {
      position: "relative",
      width: "100%",
      height: 60,
    },
    input: {
      ...CustomStyles.fontHead20,
      width: "100%",
      height: "100%",
      padding: "10px",
      color: CustomStyles.primaryBlack,
      border: "0.5px solid #969696",
      borderRadius: 16,
      boxSizing: "border-box",
    },
    button: {
      ...CustomStyles.fontHead20,
      position: "absolute",
      top: "50%",
      right: 6,
      transform: "translateY(-50%)",
      width: 48,
      height: 48,
      backgroundColor: CustomStyles.backgroundBlue,
      color: CustomStyles.pointBlue,
      border: "none",
      borderRadius: 12,
      cursor: "pointer",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
    },
  };

  return (
    <div style={styles.wrapper}>
      <input
        style={styles.input}
        type="text"
        placeholder={placeholder}
        value={input}
        onChange={(e) => setInput(e.target.value)}
      />
      <button style={styles.button} onClick={() => onClick?.(input)}>
        {buttonText}
      </button>
    </div>
  );
};

export default InputBar;
