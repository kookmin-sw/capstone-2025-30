import React from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import { ReactComponent as IconBack } from "@/assets/icons/back.svg";

const ChatHeader = ({ text }) => {
  const navigate = useNavigate();

  const goBack = () => {
    navigate(-1);
  };

  const styles = {
    container: {
      position: "relative",
      display: "flex",
      alignItems: "center",
      height: 64,
      backgroundColor: CustomStyles.backgroundBlue,
    },
    button: {
      position: "absolute",
      top: "50%",
      left: 25,
      transform: "translateY(-50%)",
      background: "none",
      border: "none",
      cursor: "pointer",
    },
    text: {
      ...CustomStyles.fontHead24,
      flex: 1,
      textAlign: "center",
    },
  };

  return (
    <div style={styles.container}>
      <button style={styles.button} onClick={goBack}>
        <IconBack />
      </button>
      <div style={styles.text}>{text}</div>
    </div>
  );
};

export default ChatHeader;
