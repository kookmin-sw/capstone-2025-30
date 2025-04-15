import React from "react";
import { useLocation } from "react-router-dom";

import Header from "@/components/Header";

const OrderNumberPage = () => {
  const { state } = useLocation();
  return (
    <>
      <Header centerIcon={null} cartIcon={null} goTo="/" />

      <div
        style={{
          padding: "0 30px",
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
        }}
      >
        <div
          style={{
            width: "100%",
            paddingTop: "100%",
            backgroundColor: "#D0D0D0",
            borderRadius: 16,
          }}
        />

        <div
          style={{
            fontSize: 60,
            lineHeight: "68px",
            fontFamily: "Pretendard",
            fontWeight: 700,
            marginTop: 40,
          }}
        >
          {state?.orderNumber}
        </div>
      </div>
    </>
  );
};

export default OrderNumberPage;
