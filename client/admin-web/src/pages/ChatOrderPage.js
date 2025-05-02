import React from "react";
import { useLocation } from "react-router-dom";

import ChatOrderStyles from "@/pages/ChatOrderStyles";

import ChatHeader from "@/components/ChatHeader";
import ChatBubble from "@/components/ChatBubble";
import AnswerOption from "@/components/AnswerOption";
import ChatInputBar from "@/components/ChatInputBar";

const ChatOrderPage = () => {
  const { state } = useLocation();

  const chat = [
    {
      isFirst: true,
      isAdmin: false,
      text: `아메리카노 아이스 S사이즈 1잔\n카페라떼 핫 S 사이즈 샷추가 1번 1잔`,
      onClick: null,
    },
    {
      isFirst: false,
      isAdmin: true,
      text: "다른 문의사항 있으신가요?",
      onClick: null,
    },
    {
      isFirst: false,
      isAdmin: false,
      text: "얼음 많이 주세요.",
      onClick: null,
    },
    {
      isFirst: false,
      isAdmin: true,
      text: "네",
      onClick: null,
    },
    {
      isFirst: false,
      isAdmin: true,
      text: "결제해드릴게요",
      onClick: null,
    },
    {
      isFirst: false,
      isAdmin: true,
      text: "결제해드릴게요",
      onClick: null,
    },
    {
      isFirst: false,
      isAdmin: true,
      text: "결제해드릴게요",
      onClick: null,
    },
  ];

  return (
    <div style={ChatOrderStyles.container}>
      <div style={{ position: "fixed", width: "100%" }}>
        <ChatHeader text={state?.chatTitle} />
      </div>
      <div style={ChatOrderStyles.chatBubble}>
        {chat.map((item, index) => (
          <ChatBubble
            key={index}
            isFirst={item.isFirst}
            isAdmin={item.isAdmin}
            text={item.text}
            onClick={item.onClick}
          />
        ))}
      </div>

      <div style={ChatOrderStyles.bottomContainer}>
        <AnswerOption
          textList={[
            "네",
            "아니오",
            "잠시만 기다려주세요",
            "다른 문의사항 있으신가요?",
            "결제해드릴게요",
          ]}
        />
        <ChatInputBar placeholder="직접 입력하세요." onClick={null} />
      </div>
    </div>
  );
};

export default ChatOrderPage;
