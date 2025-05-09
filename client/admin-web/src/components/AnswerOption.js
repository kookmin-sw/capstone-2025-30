import React from "react";
import CustomStyles from "@/styles/CustomStyles";

const AnswerOption = ({ textList = [], onClick = null }) => {
  const styles = {
    container: {
      ...CustomStyles.fontHead16,
      padding: "10px 15px",
      alignItems: "center",
      backgroundColor: CustomStyles.pointGray,
      color: CustomStyles.primaryWhite,
      border: "none",
      borderRadius: 16,
      margin: "0 0 10px 15px",
    },
  };

  return (
    <>
      {textList.map((item, index) => (
        <button
          key={index}
          style={styles.container}
          onClick={() => onClick?.(item)}
        >
          {item}
        </button>
      ))}
    </>
  );
};

export default AnswerOption;
