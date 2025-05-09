import React, { useState } from "react";
import CustomStyles from "@/styles/CustomStyles";
import { ReactComponent as IconChatSend } from "@/assets/icons/chat-send.svg";

const ChatInputBar = ({ placeholder, onClick }) => {
  const [input, setInput] = useState("");

  const styles = {
    wrapper: {
      position: "relative",
      width: "100%",
      height: 40,
    },
    input: {
      ...CustomStyles.fontHead16,
      width: "100%",
      height: "100%",
      padding: "10px",
      color: CustomStyles.primaryBlack,
      border: "0.5px solid #969696",
      borderRadius: 32,
      boxSizing: "border-box",
    },
    button: {
      ...CustomStyles.fontHead20,
      position: "absolute",
      top: "50%",
      right: 6,
      transform: "translateY(-50%)",
      width: 32,
      height: 32,
      backgroundColor: CustomStyles.backgroundBlue,
      color: CustomStyles.pointBlue,
      border: "none",
      borderRadius: 32,
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
      <button
        style={styles.button}
        onClick={() => {
          if (input.trim()) {
            onClick?.(input);
            setInput("");
          }
        }}
      >
        <IconChatSend />
      </button>
    </div>
  );
};

export default ChatInputBar;
