import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CheckOrderNumberStyles from "@/pages/checkOrder/CheckOrderNumberStyles";

import Header from "@/components/Header";
import { ReactComponent as IconCheck } from "@/assets/icons/check.svg";
import Button from "@/components/Button";
import SignVideo from "@/components/SignVideo";

const CheckOrderNumberPage = () => {
  const navigate = useNavigate();
  const [value, setValue] = useState("");

  return (
    <>
      <Header centerIcon="✅" cartIcon={null} />

      <div style={{ ...CheckOrderNumberStyles.container }}>
        {/* 숫자 키패드가 잘 나오는지 모바일 환경에서 확인 필요 */}
        <input
          type="text"
          inputMode="numeric"
          pattern="[0-9]*"
          placeholder="주문번호 입력"
          value={value}
          onChange={(e) => setValue(e.target.value)}
          style={{ ...CheckOrderNumberStyles.inputOrderNumber }}
        />

        <div style={{ margin: "0 0 70px 0" }}>
          <SignVideo src="/assets/video/주문번호를입력해주세요.mp4" />
        </div>

        <Button
          icon={<IconCheck />}
          text="입력 완료"
          disabled={value.length === 0}
          onClick={() => {
            value.length !== 0 &&
              navigate("/order-process", {
                state: { checkOrderNumber: value },
              });
          }}
        />
      </div>
    </>
  );
};

export default CheckOrderNumberPage;
