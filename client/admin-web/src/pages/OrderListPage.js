import React, { useState, useEffect } from "react";
import { useNavigate, useLocation } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import OrderListStyles from "@/pages/OrderListStyles";

import { getChatRoomList } from "../config/api.js";
import InputBar from "@/components/InputBar";
import OrderList from "@/components/OrderList";

const TABS = ["이전", "완료"];

const OrderListPage = () => {
  const navigate = useNavigate();
  const { state } = useLocation();
  const [activeTab, setActiveTab] = useState(0);
  const [chatRoomInfo, setChatRoomInfo] = useState([]);

  useEffect(() => {
    const fetchGetChatRoomList = async () => {
      try {
        const chatList = await getChatRoomList(
          state?.adminId,
          activeTab === 0
            ? "CHATROOM_STATUS_BEFORE"
            : "CHATROOM_STATUS_COMPLETE"
        );
        console.log(chatList.data.chat_room_info);
        // setChatRoomInfo(chatList.data.chat_room_info);
      } catch (error) {
        console.error(
          "관리자 채팅 리스트 조회 오류:",
          error.response ? error.response.data : error.message
        );
      }
    };
    fetchGetChatRoomList();
  }, [state?.adminId, activeTab]);

  return (
    <div style={OrderListStyles.container}>
      <div style={OrderListStyles.gradientInputBar}>
        <InputBar
          placeholder="주문번호를 입력해주세요."
          buttonText="등록"
          onClick={null}
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
                      chatTitle: `${
                        item.isOrder ? "주문번호 : " : "일반문의 "
                      }${item.text}`,
                      adminId: state?.adminId,
                      type: item.notification_title,
                      number: item.number,
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
                      chatTitle: `${
                        item.isOrder ? "주문번호 : " : "일반문의 "
                      }${item.text}`,
                      adminId: state?.adminId,
                      type: item.notification_title,
                      number: item.number,
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
