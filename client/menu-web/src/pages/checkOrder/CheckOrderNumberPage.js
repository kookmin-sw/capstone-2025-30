import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CheckOrderNumberStyles from "@/pages/checkOrder/CheckOrderNumberStyles";

import { getOrderNumber } from "../../config/api";
import Header from "@/components/Header";
import { ReactComponent as IconCheck } from "@/assets/icons/check.svg";
import Button from "@/components/Button";
import SignVideo from "@/components/SignVideo";
import BottomSheet from "@/components/BottomSheet";

const CheckOrderNumberPage = () => {
  const navigate = useNavigate();
  const [value, setValue] = useState("");
  const [isBottomSheetOpen, setIsBottomSheetOpen] = useState(false);

  const videos = [
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%A1%E1%84%89%E1%85%A6%E1%84%8B%E1%85%AD%2C%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%B5+%E1%84%80%E1%85%A1%E1%84%89%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%84%8B%E1%85%A9.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%84%86%E1%85%AE%E1%86%AB.mp4",
  ];

  const fetchGetOrderNumber = async () => {
    try {
      const category = await getOrderNumber(value);
      if (category) {
        navigate("/order-process", {
          state: {
            checkOrderNumber: value,
          },
        });
      }
    } catch (error) {
      console.error(
        "주문 과정 조회 오류:",
        error.response ? error.response.data : error.message
      );
      setIsBottomSheetOpen(true);
    }
  };

  return (
    <>
      <Header centerIcon="✅" cartIcon={null} />

      <div style={CheckOrderNumberStyles.container}>
        {/* 숫자 키패드가 잘 나오는지 모바일 환경에서 확인 필요 */}
        <input
          type="text"
          inputMode="numeric"
          pattern="[0-9]*"
          placeholder="주문번호 입력"
          value={value}
          onChange={(e) => setValue(e.target.value)}
          style={CheckOrderNumberStyles.inputOrderNumber}
        />

        <div style={{ margin: "0 0 70px 0" }}>
          {/* 주문번호를입력해주세요 */}
          <SignVideo srcList={videos} />
        </div>

        <Button
          icon={<IconCheck />}
          text="입력 완료"
          disabled={value.length === 0}
          onClick={fetchGetOrderNumber}
        />
      </div>

      {isBottomSheetOpen && (
        <BottomSheet onClose={() => setIsBottomSheetOpen(false)}>
          {/* 없는주문번호입니다 */}
          <SignVideo
            srcList={videos}
            isOnce={true}
            onVideoEnd={() => setIsBottomSheetOpen(false)}
          />
        </BottomSheet>
      )}
    </>
  );
};

export default CheckOrderNumberPage;
