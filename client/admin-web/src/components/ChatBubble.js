import React from "react";
import CustomStyles from "@/styles/CustomStyles";

const ChatBubble = ({
  isDone = false,
  isFirst = false,
  isAdmin = false,
  text,
  onClick,
}) => {
  const styles = {
    container: {
      display: "flex",
      flexDirection: isAdmin ? "row-reverse" : "row",
    },
    chatBubble: {
      ...CustomStyles.fontSub16,
      padding: "10px 15px",
      display: "flex",
      flexDirection: "column",
      width: "fit-content",
      backgroundColor: isAdmin
        ? CustomStyles.primaryGray
        : CustomStyles.pointBlue,
      color: CustomStyles.primaryBlack,
      border: "none",
      borderRadius: 16,
      boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.15)",
      marginBottom: 20,
      whiteSpace: "pre-line",
    },
    button: {
      ...CustomStyles.fontCaption,
      fontWeight: isDone ? 500 : 700,
      color: isDone ? CustomStyles.primaryGray : CustomStyles.primaryBlack,
      width: "100%",
      height: 32,
      border: "none",
      borderRadius: 16,
      marginTop: 10,
    },
    timeContainer: {
      display: "flex",
      justifyContent: isAdmin ? "flex-start" : "flex-end",
    },
    time: {
      ...CustomStyles.fontCaption,
      margin: "24px 10px",
      alignSelf: "flex-end",
    },
  };

  return (
    <div style={styles.container}>
      <div style={styles.chatBubble}>
        {text}
        {isFirst && (
          <button style={styles.button} onClick={onClick}>
            제조완료로 상태 변경
          </button>
        )}
      </div>
      <div style={styles.timeContainer}>
        <div style={styles.time}>오후 01:12</div>
      </div>
    </div>
  );
};

export default ChatBubble;
