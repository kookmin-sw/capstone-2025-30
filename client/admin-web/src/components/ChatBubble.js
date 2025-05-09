import React from "react";
import CustomStyles from "@/styles/CustomStyles";

const ChatBubble = ({
  isFirst = false,
  isAdmin = false,
  createdAt,
  text,
  onClick,
  showTime = true,
  isStatusCompleted = false,
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
      fontWeight: isStatusCompleted ? 500 : 700,
      color: isStatusCompleted
        ? CustomStyles.pointGray
        : CustomStyles.primaryBlack,
      width: "100%",
      height: 32,
      border: "none",
      borderRadius: 16,
      marginTop: 10,
      padding: "0 20px",
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

  const formatTime = (isoString) => {
    const date = new Date(isoString);

    let hours = date.getHours();
    const minute = date.getMinutes();
    const isPM = hours >= 12;

    const formattedHour = (((hours + 11) % 12) + 1).toString().padStart(2, "0");
    const formattedMinute = minute.toString().padStart(2, "0");

    return `${isPM ? "오후" : "오전"} ${formattedHour}:${formattedMinute}`;
  };

  return (
    <div style={styles.container}>
      <div style={styles.chatBubble}>
        {text}
        {isFirst && (
          <button style={styles.button} onClick={onClick}>
            {isStatusCompleted
              ? "제조완료로 상태 변경 완료"
              : "제조완료로 상태 변경"}
          </button>
        )}
      </div>
      {showTime && (
        <div style={styles.timeContainer}>
          <div style={styles.time}>{formatTime(createdAt)}</div>
        </div>
      )}
    </div>
  );
};

export default ChatBubble;
