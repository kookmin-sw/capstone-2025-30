import React from "react";

import Header from "@/components/Header";

const OrderNumberPage = () => {
  return (
    <>
      <Header centerIcon={null} goTo="/" />

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
          163
        </div>
      </div>
    </>
  );
};

export default OrderNumberPage;
