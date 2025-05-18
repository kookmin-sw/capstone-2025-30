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
        <div style={OrderProcessStyles.line} />
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

  const videos1 = [
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%A6%E1%84%82%E1%85%B2.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%86%AB%E1%84%87%E1%85%B5.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%86%BC%E1%84%8B%E1%85%A1%E1%86%BC%2C%20%E1%84%83%E1%85%A9%E1%84%8C%E1%85%AE%E1%86%BC%2C%20%E1%84%8C%E1%85%AE%E1%86%BC%2C%20%E1%84%80%E1%85%A1%E1%84%8B%E1%85%AE%E1%86%AB%E1%84%83%E1%85%A6%2C%20%E1%84%8C%E1%85%AE%E1%86%BC%E1%84%89%E1%85%B5%E1%86%B7.mp4",
  ];

  const videos2 = [
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%89%E1%85%A5%E1%86%BC%2C%20%E1%84%8C%E1%85%A6%E1%84%8C%E1%85%A1%E1%86%A8%2C%20%E1%84%8C%E1%85%A6%E1%84%8C%E1%85%A9%2C%20%E1%84%86%E1%85%A1%E1%86%AB%E1%84%83%E1%85%B3%E1%86%AF%E1%84%83%E1%85%A1%2C%20%E1%84%80%E1%85%A1%E1%84%80%E1%85%A9%E1%86%BC.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%A9%E1%86%BC%E1%84%85%E1%85%AD%2C%20%E1%84%81%E1%85%B3%E1%87%80%E1%84%82%E1%85%A1%E1%84%83%E1%85%A1%2C%20%E1%84%86%E1%85%A1%E1%84%8E%E1%85%B5%E1%84%83%E1%85%A1.mp4",
  ];

  useEffect(() => {
    const fetchGetOrderNumber = async () => {
      try {
        const category = await getOrderNumber(state?.checkOrderNumber);
        setOrderInformation(category.data);
        setMenu(category.data.items);
      } catch (error) {
        console.error(
          "주문 과정 조회 오류:",
          error.response ? error.response.data : error.message
        );
      }
    };
    fetchGetOrderNumber();

    const intervalId = setInterval(() => {
      fetchGetOrderNumber();
    }, 30000);

    return () => clearInterval(intervalId);
  }, [state?.checkOrderNumber]);

  return (
    <>
      <Header centerIcon="✅" cartIcon={null} />

      {orderInformation?.dine_in ? (
        <div style={OrderProcessStyles.container}>
          <div style={OrderProcessStyles.textProcess}>메뉴 준비중</div>

          <div style={{ margin: "0 0 70px 0" }}>
            {/* 메뉴준비중입니다 */}
            <SignVideo srcList={videos1} />
          </div>

          {menu.map((item, idx) => (
            <OrderList key={idx} menu={item} isLast={idx === menu.length - 1} />
          ))}
        </div>
      ) : (
        <div style={OrderProcessStyles.container}>
          <div style={OrderProcessStyles.textProcess}>제조 완료</div>
          {/* 제조완료 */}
          <SignVideo srcList={videos2} />
        </div>
      )}
    </>
  );
};

export default OrderProcessPage;
