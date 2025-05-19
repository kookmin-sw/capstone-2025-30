import React, { useEffect, useState, useRef } from "react";
import { useLocation } from "react-router-dom";

import ChatOrderStyles from "@/pages/ChatOrderStyles";

import { getChatMessages, modifyStatus } from "../config/api.js";
import { useWebSocket } from "../context/WebSocketProvider";
import ChatHeader from "@/components/ChatHeader";
import ChatBubble from "@/components/ChatBubble";
import AnswerOption from "@/components/AnswerOption";
import ChatInputBar from "@/components/ChatInputBar";

const ChatOrderPage = () => {
  const messagesEndRef = useRef(null);

  const { state } = useLocation();
  const { sendMessage, messages } = useWebSocket();

  const [chatList, setChatList] = useState([]);
  const [isStatusCompleted, setIsStatusCompleted] = useState(state?.isDone);

  useEffect(() => {
    const fetchGetChatMessages = async () => {
      try {
        const chatMessages = await getChatMessages(
          state?.adminId,
          state?.type,
          state?.number
        );
        setChatList(chatMessages.data.messages);
      } catch (error) {
        console.error(
          "관리자 채팅 조회 오류:",
          error.response ? error.response.data : error.message
        );
      }
    };
    fetchGetChatMessages();
  }, [state?.adminId, state?.type, state?.number]);

  const fetchModifyStatus = async () => {
    try {
      await modifyStatus(state?.adminId, state?.number);
      setIsStatusCompleted(true);
    } catch (error) {
      console.error(
        "관리자 상태 변경 오류:",
        error.response ? error.response.data : error.message
      );
    }
  };

  useEffect(() => {
    if (messages.length > 0) {
      const latest = messages[messages.length - 1];
      try {
        const parsed = JSON.parse(latest);

        if (parsed.status === "success") {
          return;
        }

        if (parsed.data) {
          setChatList((prev) => [
            ...prev,
            {
              type: parsed.type,
              message: parsed.data.message,
              is_owner: false,
              created_at: parsed.data.created_at,
            },
          ]);
        }
      } catch (err) {
        console.error("메시지 파싱 실패:", err);
      }
    }
  }, [messages]);

  const handleSendMessage = (text, answerOption = false) => {
    if (!answerOption && (!text || !text.trim())) return;

    const payload = {
      title: state?.type === "order" ? "orderMessage" : "inquiryMessage",
      number: state?.number,
      message: text,
      store_code: "5fjVwE8z",
    };

    sendMessage(payload);

    setChatList((prev) => [
      ...prev,
      {
        message: text,
        is_owner: true,
        created_at: new Date().toISOString(),
      },
    ]);
  };

  useEffect(() => {
    const scrollToBottom = () => {
      messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
    };
    scrollToBottom();
  }, [chatList]);

  return (
    <div style={ChatOrderStyles.container}>
      <div style={{ position: "fixed", width: "100%" }}>
        <ChatHeader
          text={
            state?.type === "order"
              ? `주문번호 ${state?.number}`
              : `일반문의 ${state?.number}`
          }
        />
      </div>

      <div
        style={{
          ...ChatOrderStyles.chatBubble,
          padding: `88px 30px ${isStatusCompleted ? 0 : 180}px 30px`,
        }}
      >
        {chatList.map((item, index, arr) => {
          const currentTime = new Date(item.created_at);
          const currentKey = `${
            item.is_owner
          }-${currentTime.getHours()}:${currentTime.getMinutes()}`;
          const nextItem = arr[index + 1];
          const nextKey = nextItem
            ? `${nextItem.is_owner}-${new Date(
                nextItem.created_at
              ).getHours()}:${new Date(nextItem.created_at).getMinutes()}`
            : null;
          const showTime = currentKey !== nextKey;
          return (
            <ChatBubble
              key={index}
              isFirst={index === 0 && arr[0].type !== "signMessage"}
              isAdmin={item.is_owner}
              text={item.message}
              createdAt={item.created_at}
              onClick={fetchModifyStatus}
              showTime={showTime}
              isStatusCompleted={isStatusCompleted}
            />
          );
        })}
        <div ref={messagesEndRef} />
      </div>

      {!isStatusCompleted && (
        <div style={ChatOrderStyles.bottomContainer}>
          <AnswerOption
            textList={[
              "네",
              "아니오",
              "잠시만 기다려주세요",
              "다른 문의사항 있으신가요?",
              "결제해드릴게요",
            ]}
            onClick={(text) => handleSendMessage(text, true)}
          />
          <ChatInputBar
            placeholder="직접 입력하세요."
            onClick={(text) => handleSendMessage(text)}
          />
        </div>
      )}
    </div>
  );
};

export default ChatOrderPage;
