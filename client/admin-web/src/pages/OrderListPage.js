import React, { useState, useEffect } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { toast } from "react-toastify";

import CustomStyles from "@/styles/CustomStyles";
import OrderListStyles from "@/pages/OrderListStyles";

import { getChatRoomList, getChatMessages } from "../config/api.js";
import { useWebSocket } from "../context/WebSocketProvider";
import InputBar from "@/components/InputBar";
import OrderList from "@/components/OrderList";

const TABS = ["이전", "완료"];

const OrderListPage = () => {
  const navigate = useNavigate();
  const { state } = useLocation();
  const [activeTab, setActiveTab] = useState(0);
  const [chatRoomInfo, setChatRoomInfo] = useState([]);
  const { isConnected } = useWebSocket();

  useEffect(() => {
    if (isConnected) {
      console.log("연결 상태:", isConnected);
    }
  }, [isConnected]);

  useEffect(() => {
    const fetchGetChatRoomList = async () => {
      try {
        const chatList = await getChatRoomList(
          state?.adminId,
          activeTab === 0
            ? "CHATROOM_STATUS_BEFORE"
            : "CHATROOM_STATUS_COMPLETE"
        );
        setChatRoomInfo(chatList.data.chat_room_info);
      } catch (error) {
        console.error(
          "관리자 채팅 리스트 조회 오류:",
          error.response ? error.response.data : error.message
        );
      }
    };
    fetchGetChatRoomList();
  }, [state?.adminId, activeTab]);

  const fetchGetOrder = async (number) => {
    try {
      await getChatMessages(state?.adminId, "order", number);
      navigate("/chat-order", {
        state: {
          adminId: state?.adminId,
          type: "order",
          number: number,
          isDone: false,
        },
      });
    } catch (error) {
      toast.error("존재하지 않는 주문번호입니다.", {
        position: "top-center",
        autoClose: 2000,
        hideProgressBar: true,
        closeOnClick: true,
        pauseOnHover: false,
        draggable: true,
        theme: "light",
      });
      console.error(
        "관리자 채팅 리스트 조회 오류:",
        error.response ? error.response.data : error.message
      );
    }
  };

  return (
    <div style={OrderListStyles.container}>
      <div style={OrderListStyles.gradientInputBar}>
        <InputBar
          placeholder="주문번호를 입력해주세요."
          buttonText="등록"
          onClick={(inputValue) => fetchGetOrder(inputValue)}
        />
      </div>

      <div style={{ display: "flex" }}>
        {TABS.map((label, idx) => (
          <button
            key={label}
            onClick={() => setActiveTab(idx)}
            style={{
              ...OrderListStyles.tab,
              borderBottom:
                activeTab === idx
                  ? "4px solid #458EFD"
                  : "1px solid rgba(69, 142, 253, 0.2)",
              color:
                activeTab === idx
                  ? CustomStyles.primaryBlack
                  : CustomStyles.primaryBlack,
              fontWeight: activeTab === idx ? "700" : "400",
            }}
          >
            {label}
          </button>
        ))}
      </div>

      <div style={OrderListStyles.tabContent}>
        {activeTab === 0 && (
          <>
            {chatRoomInfo.map((item, idx) => (
              <OrderList
                key={idx}
                type={item.notification_title}
                isDone={false}
                text={item.number}
                onClick={() =>
                  navigate("/chat-order", {
                    state: {
                      adminId: state?.adminId,
                      type: item.notification_title,
                      number: item.number,
                      isDone: false,
                    },
                  })
                }
              />
            ))}
          </>
        )}
        {activeTab === 1 && (
          <>
            {chatRoomInfo.map((item, idx) => (
              <OrderList
                key={idx}
                type={item.notification_title}
                isDone={true}
                text={item.number}
                onClick={() =>
                  navigate("/chat-order", {
                    state: {
                      adminId: state?.adminId,
                      type: item.notification_title,
                      number: item.number,
                      isDone: true,
                    },
                  })
                }
              />
            ))}
          </>
        )}
      </div>
    </div>
  );
};

export default OrderListPage;
