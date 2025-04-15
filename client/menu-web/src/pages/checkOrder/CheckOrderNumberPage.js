import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import CheckOrderNumberStyles from "@/pages/checkOrder/CheckOrderNumberStyles";

import Header from "@/components/Header";
import { ReactComponent as IconCheck } from "@/assets/icons/check.svg";
import Button from "@/components/Button";

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
          style={{
            ...CustomStyles.fontHead28,
            textAlign: "center",
            padding: "8px 0",
            width: "100%",
            border: "none",
            borderBottom: "1px solid #969696",
            outline: "none",
            margin: "20px 0 40px 0",
          }}
        />

        <div
          style={{
            width: "100%",
            paddingTop: "100%",
            backgroundColor: "#D0D0D0",
            borderRadius: 16,
            marginBottom: 72,
          }}
        />

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
