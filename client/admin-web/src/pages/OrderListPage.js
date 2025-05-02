import React, { useState } from "react";

import CustomStyles from "@/styles/CustomStyles";
import OrderListStyles from "@/pages/OrderListStyles";

import InputBar from "@/components/InputBar";
import OrderList from "@/components/OrderList";

const TABS = ["이전", "완료"];

const OrderListPage = () => {
  const [activeTab, setActiveTab] = useState(0);

  const orders = [
    { isDone: false, isOrder: true, text: 1, onClick: null },
    { isDone: false, isOrder: false, text: 2, onClick: null },
    { isDone: false, isOrder: true, text: 3, onClick: null },
    { isDone: false, isOrder: false, text: 4, onClick: null },
    { isDone: false, isOrder: true, text: 5, onClick: null },
    { isDone: true, isOrder: false, text: 6, onClick: null },
    { isDone: true, isOrder: true, text: 7, onClick: null },
  ];

  const filteredOrders = orders.filter((item) =>
    activeTab === 0 ? !item.isDone : item.isDone
  );

  return (
    <div style={OrderListStyles.container}>
      <div style={{ padding: "30px 0 10px 30px" }}>
        <InputBar
          placeholder="주문번호를 입력해주세요."
          buttonText="등록"
          onClick={null}
        />
      </div>

      <div style={{ display: "flex", width: "100%" }}>
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

      <div style={{ padding: "20px 30px" }}>
        {activeTab === 0 && (
          <>
            {filteredOrders.map((item, idx) => (
              <OrderList
                key={idx}
                isOrder={item.isOrder}
                isDone={item.isDone}
                text={item.text}
                onClick={item.onClick}
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
                onClick={item.onClick}
              />
            ))}
          </>
        )}
      </div>
    </div>
  );
};

export default OrderListPage;
