import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";

import MenuStyles from "@/pages/order/MenuStyles";

import { getMenu } from "../../config/api";
import { useCart } from "../../context/CartContext";
import Header from "@/components/Header";
import SignVideo from "@/components/SignVideo";
import ButtonMenu from "@/components/ButtonMenu";
import BottomCart from "@/components/BottomCart";

const MenuPage = () => {
  const { categoryPath } = useParams();
  const { cartItems } = useCart();
  const [menus, setMenus] = useState([]);

  const videos = [
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EA%B0%81%EA%B0%81%2C%20%EA%B0%81%2C%20%EA%B0%9C%EB%B3%84.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A9%94%EB%89%B4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%A6%E1%84%82%E1%85%B2+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A9%94%EB%89%B4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%84%A4%EB%AA%85.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%82%B4%ED%8E%B4%EB%B3%B4%EB%8B%A4%2C%EC%82%B4%ED%94%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A3%BC%EB%AC%B8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EA%B0%80%EB%8A%A5%2C%20%ED%95%A0%20%EC%88%98%20%EC%9E%88%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A3%BC%EB%AC%B8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A2%85%EB%A3%8C%2C%EB%81%9D%EB%82%98%EB%8B%A4%2C%EB%A7%88%EC%B9%98%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%98%90.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A3%BC%EB%AC%B8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%83%81%ED%83%9C%2C%20%EC%83%81%ED%99%A9.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%82%B4%ED%8E%B4%EB%B3%B4%EB%8B%A4%2C%EC%82%B4%ED%94%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%98%A4%EB%A5%B8%EC%AA%BD.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9C%84.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8F%E1%85%A1%E1%84%90%E1%85%B3+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
    "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
  ];

  useEffect(() => {
    const fetchGetMenu = async () => {
      try {
        const category = await getMenu(categoryPath);
        setMenus(category.data.menus);
      } catch (error) {
        console.error(
          "메뉴 조회 오류:",
          error.response ? error.response.data : error.message
        );
      }
    };
    fetchGetMenu();
  }, [categoryPath]);

  return (
    <div style={{ marginBottom: 40 }}>
      {categoryPath === "커피" && <Header centerIcon="☕️" />}
      {categoryPath === "차" && <Header centerIcon="🌿" />}
      {categoryPath === "음료" && <Header centerIcon="🧋" />}
      {categoryPath === "케이크" && <Header centerIcon="🍰" />}
      {categoryPath === "빵" && <Header centerIcon="🥯" />}
      {categoryPath === "샐러드" && <Header centerIcon="🥗" />}

      <div style={MenuStyles.container}>
        <SignVideo srcList={videos} />

        {menus && menus.length > 0 ? (
          <div
            style={{
              ...MenuStyles.containerMenu,
              paddingBottom: cartItems.length > 0 ? 60 : 0,
            }}
          >
            {menus.map((item, idx) => (
              <ButtonMenu key={idx} menu={item} />
            ))}
          </div>
        ) : (
          <></>
        )}
      </div>

      {cartItems.length > 0 && (
        <div
          style={{
            position: "fixed",
            bottom: 0,
            left: 0,
            width: "100%",
            zIndex: 100,
          }}
        >
          <BottomCart />
        </div>
      )}
    </div>
  );
};

export default MenuPage;
