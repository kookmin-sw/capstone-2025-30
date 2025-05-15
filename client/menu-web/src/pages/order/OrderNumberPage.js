import React from "react";
import { useLocation } from "react-router-dom";

import Header from "@/components/Header";
import SignVideo from "@/components/SignVideo";

const OrderNumberPage = () => {
  const { state } = useLocation();

  const videos = [
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EA%B3%84%EC%82%B0%EB%8C%80%2C%EC%B9%B4%EC%9A%B4%ED%84%B0.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%ED%9C%B4%EB%8C%80%ED%8F%B0%2C%20%ED%95%B8%EB%93%9C%ED%8F%B0.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B3%B4%EC%97%AC%EC%A3%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%80%EC%A7%81%EC%9D%B4%EB%8B%A4.mp4",
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
