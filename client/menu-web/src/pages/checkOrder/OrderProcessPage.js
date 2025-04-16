import React, { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import OrderProcessStyles from "@/pages/checkOrder/OrderProcessStyles";

import { getOrderNumber } from "../../config/api";
import Header from "@/components/Header";
import ButtonMenu from "@/components/ButtonMenu";
import SignVideo from "@/components/SignVideo";
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
          {menu.options.choices.temperature === "차갑게" ? (
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
              {menu.options.choices.size === "적게"
                ? "S"
                : menu.options.choices.size === "보통"
                ? "M"
                : "L"}
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
  const { state } = useLocation();
  const [orderInformation, setOrderInformation] = useState([]);
  const [menu, setMenu] = useState([]);

  useEffect(() => {
    const fetchGetOrderNumber = async () => {
      try {
        const category = await getOrderNumber(state?.checkOrderNumber);
        setOrderInformation(category.data);
        setMenu(category.data.items);
        console.log(category.data);
      } catch (error) {
        console.error(
          "주문 과정 조회 오류:",
          error.response ? error.response.data : error.message
        );
      }
    };
    fetchGetOrderNumber();
  }, [state?.checkOrderNumber]);

  return (
    <>
      <Header centerIcon="✅" cartIcon={null} />

      {orderInformation?.dine_in ? (
        <div style={{ ...OrderProcessStyles.container }}>
          <div style={{ ...OrderProcessStyles.textProcess }}>메뉴 준비중</div>

          <div style={{ margin: "0 0 70px 0" }}>
            <SignVideo src="/assets/video/메뉴준비중입니다.mp4" />
          </div>

          {menu.map((item, idx) => (
            <OrderList key={idx} menu={item} isLast={idx === menu.length - 1} />
          ))}
        </div>
      ) : (
        <div style={{ ...OrderProcessStyles.container }}>
          <div style={{ ...OrderProcessStyles.textProcess }}>제조 완료</div>
          <SignVideo src="/assets/video/제조완료.mp4" />
        </div>
      )}
    </>
  );
};

export default OrderProcessPage;
