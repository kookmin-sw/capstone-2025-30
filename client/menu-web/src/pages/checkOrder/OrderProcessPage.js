import React from "react";

import CustomStyles from "@/styles/CustomStyles";
import OrderProcessStyles from "@/pages/checkOrder/OrderProcessStyles";

import Header from "@/components/Header";
import ButtonMenu from "@/components/ButtonMenu";
import { ReactComponent as IconCold } from "@/assets/icons/cold.svg";
import { ReactComponent as IconHot } from "@/assets/icons/hot.svg";
import { ReactComponent as IconSize } from "@/assets/icons/size.svg";

const OrderList = ({ menu, isLast }) => {
  return (
    <>
      <div
        style={{
          display: "flex",
          justifyContent: "space-between",
          padding: "0 12px",
        }}
      >
        <ButtonMenu menu={menu} isNull={true} />

        <div
          style={{
            display: "flex",
            alignItems: "center",
          }}
        >
          {menu.temp === "ice" ? (
            <div style={{ color: CustomStyles.pointBlue, margin: "0 4px" }}>
              <IconCold width={30} height={30} />
            </div>
          ) : (
            <div style={{ color: CustomStyles.pointRed, margin: "0 4px" }}>
              <IconHot width={25} height={30} />
            </div>
          )}
          <div
            style={{
              position: "relative",
              color: CustomStyles.pointBlue,
              margin: "0 4px",
            }}
          >
            <div style={{ ...OrderProcessStyles.textSize, margin: "8px 0" }}>
              {menu.size}
            </div>
            <IconSize width={30} height={32.73} />
          </div>
        </div>
      </div>
      {!isLast ? (
        <div style={{ ...OrderProcessStyles.line }} />
      ) : (
        <div style={{ height: 70 }} />
      )}
    </>
  );
};

const OrderProcessPage = () => {
  const menu = [
    { text: "아메리카노", price: 4500, temp: "ice", size: "S", count: 1 },
    { text: "카페라떼", price: 4500, temp: "hot", size: "L", count: 1 },
    { text: "콜드브루", price: 4500, temp: "ice", size: "M", count: 1 },
  ];

  const isCompleted = true; // 확인용 임시 변수

  return (
    <>
      <Header centerIcon="✅" cartIcon={null} />

      {isCompleted ? (
        <div style={{ ...OrderProcessStyles.container }}>
          <div style={{ ...OrderProcessStyles.textProcess }}>메뉴 준비중</div>

          <div
            style={{
              width: "100%",
              paddingTop: "100%",
              backgroundColor: "#D0D0D0",
              borderRadius: 16,
              marginBottom: 72,
            }}
          />

          {menu.map((item, idx) => (
            <OrderList key={idx} menu={item} isLast={idx === menu.length - 1} />
          ))}
        </div>
      ) : (
        <div style={{ ...OrderProcessStyles.container }}>
          <div style={{ ...OrderProcessStyles.textProcess }}>제조 완료</div>

          <div
            style={{
              width: "100%",
              paddingTop: "100%",
              backgroundColor: "#D0D0D0",
              borderRadius: 16,
              marginBottom: 72,
            }}
          />
        </div>
      )}
    </>
  );
};

export default OrderProcessPage;
