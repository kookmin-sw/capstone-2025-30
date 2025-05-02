import React from "react";
import { useNavigate } from "react-router-dom";

import LoginStyles from "@/pages/LoginStyles";

import InputBar from "@/components/InputBar";

const LoginPage = () => {
  const navigate = useNavigate();

  return (
    <div style={LoginStyles.container}>
      <InputBar
        placeholder="관리자 아이디를 입력해주세요."
        buttonText="완료"
        onClick={(value) =>
          navigate("/order-list", { state: { adminId: value } })
        }
      />
    </div>
  );
};

export default LoginPage;
