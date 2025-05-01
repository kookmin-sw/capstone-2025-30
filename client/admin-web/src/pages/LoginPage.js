import React from "react";
import InputBar from "@/components/InputBar";
import LoginStyles from "@/pages/LoginStyles";

const LoginPage = () => {
  return (
    <div style={LoginStyles.container}>
      <InputBar
        placeholder="관리자 아이디를 입력해주세요."
        buttonText="완료"
        onClick={null}
      />
    </div>
  );
};

export default LoginPage;
