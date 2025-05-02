import React, { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";

import ChatOrderStyles from "@/pages/ChatOrderStyles";

import { getChatMessages } from "../config/api.js";
import ChatHeader from "@/components/ChatHeader";
import ChatBubble from "@/components/ChatBubble";
import AnswerOption from "@/components/AnswerOption";
import ChatInputBar from "@/components/ChatInputBar";

const ChatOrderPage = () => {
  const { state } = useLocation();
  const [chatMessageInfo, setChatMessageInfo] = useState([]);

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

  useEffect(() => {
    const fetchGetChatMessages = async () => {
      console.log(state?.adminId, state?.type, state?.number);
      try {
        const messageInfo = await getChatMessages(
          state?.adminId,
          state?.type,
          state?.number
        );
        console.log(messageInfo.data.messages);
        // setChatMessageInfo(messageInfo.data.messages);
      } catch (error) {
        console.error(
          "관리자 채팅 조회 오류:",
          error.response ? error.response.data : error.message
        );
      }
    };
    fetchGetChatMessages();
  }, [state?.adminId, state?.type, state?.number]);

  return (
    <div style={ChatOrderStyles.container}>
      <div style={{ position: "fixed", width: "100%" }}>
        <ChatHeader text={state?.chatTitle} />
      </div>
      <div style={ChatOrderStyles.chatBubble}>
        {chatMessageInfo.map((item, index) => (
          <ChatBubble
            key={index}
            isFirst={
              item.message && item.message.length > 0 && item.message[0]
                ? true
                : false
            }
            isAdmin={item.is_owner}
            text={item.message}
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
