import React from "react";
import { useLocation } from "react-router-dom";

import Header from "@/components/Header";
import SignVideo from "@/components/SignVideo";

const OrderNumberPage = () => {
  const { state } = useLocation();

  const videos = [
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%80%E1%85%A8%E1%84%89%E1%85%A1%E1%86%AB%E1%84%83%E1%85%A2%2C%20%E1%84%8F%E1%85%A1%E1%84%8B%E1%85%AE%E1%86%AB%E1%84%90%E1%85%A5.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%92%E1%85%B2%E1%84%83%E1%85%A2%E1%84%91%E1%85%A9%E1%86%AB%2C%20%E1%84%92%E1%85%A2%E1%86%AB%E1%84%83%E1%85%B3%E1%84%91%E1%85%A9%E1%86%AB.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A9%E1%84%8B%E1%85%A7%E1%84%8C%E1%85%AE%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%AE%E1%86%B7%E1%84%8C%E1%85%B5%E1%86%A8%E1%84%8B%E1%85%B5%E1%84%83%E1%85%A1.mp4",
  ];

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
        {/* 카운터로가서휴대폰을보여주세요 */}
        <SignVideo srcList={videos} />

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
