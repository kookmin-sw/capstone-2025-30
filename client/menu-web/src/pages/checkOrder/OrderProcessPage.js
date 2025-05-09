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
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A9%94%EB%89%B4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A4%80%EB%B9%84.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A4%91%EC%95%99%2C%EB%8F%84%EC%A4%91%2C%EC%A4%91%2C%EA%B0%80%EC%9A%B4%EB%8D%B0%2C%EC%A4%91%EC%8B%AC.mp4",
  ];

  const videos2 = [
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9E%91%EC%84%B1%2C%EC%A0%9C%EC%9E%91%2C%EC%A0%9C%EC%A1%B0%2C%EB%A7%8C%EB%93%A4%EB%8B%A4%2C%EA%B0%80%EA%B3%B5.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A2%85%EB%A3%8C%2C%EB%81%9D%EB%82%98%EB%8B%A4%2C%EB%A7%88%EC%B9%98%EB%8B%A4.mp4",
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
