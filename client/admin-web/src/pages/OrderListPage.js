import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import OrderListStyles from "@/pages/OrderListStyles";

import InputBar from "@/components/InputBar";
import OrderList from "@/components/OrderList";

const TABS = ["이전", "완료"];

const OrderListPage = () => {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState(0);

  const orders = [
    {
      isDone: false,
      isOrder: true,
      text: 1,
    },
    { isDone: false, isOrder: false, text: 2 },
    { isDone: false, isOrder: true, text: 3 },
    { isDone: false, isOrder: false, text: 4 },
    { isDone: false, isOrder: true, text: 5 },
    { isDone: true, isOrder: false, text: 6 },
    { isDone: true, isOrder: true, text: 7 },
  ];

  const filteredOrders = orders.filter((item) =>
    activeTab === 0 ? !item.isDone : item.isDone
  );

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
            {filteredOrders.map((item, idx) => (
              <OrderList
                key={idx}
                isOrder={item.isOrder}
                isDone={item.isDone}
                text={item.text}
                onClick={() =>
                  navigate("/chat-order", {
                    state: {
                      chatTitle: `${
                        item.isOrder ? "주문번호 : " : "일반문의 "
                      }${item.text}`,
                    },
                  })
                }
              />
            ))}
          </>
        )}
        {activeTab === 1 && (
          <>
            {filteredOrders.map((item, idx) => (
              <OrderList
                key={idx}
                isOrder={item.isOrder}
                isDone={item.isDone}
                text={item.text}
                onClick={() =>
                  navigate("/chat-order", {
                    state: {
                      chatTitle: `${
                        item.isOrder ? "주문번호 : " : "일반문의 "
                      }${item.text}`,
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
