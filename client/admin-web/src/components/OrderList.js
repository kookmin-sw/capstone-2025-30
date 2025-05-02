import React from "react";
import CustomStyles from "@/styles/CustomStyles";

const OrderList = ({ isDone = false, isOrder = false, text, onClick }) => {
  const styles = {
    container: {
      ...CustomStyles.fontHead20,
      width: "90%",
      height: 100,
      padding: "0 20px",
      display: "flex",
      alignItems: "center",
      backgroundColor: isDone
        ? "rgba(182, 208, 255, 0.2)"
        : CustomStyles.pointBlue,
      color: CustomStyles.primaryBlack,
      border: "none",
      borderRadius: 16,
      boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.15)",
      marginBottom: 30,
    },
  };

  return (
    <div style={styles.container} onClick={onClick}>
      {isOrder === true ? "주문번호 : " : "일반문의 "} {text}
    </div>
  );
};

export default OrderList;
