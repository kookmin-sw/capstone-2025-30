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
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%80%E1%85%A1%E1%86%A8%E1%84%80%E1%85%A1%E1%86%A8%2C%20%E1%84%80%E1%85%A1%E1%86%A8%2C%20%E1%84%80%E1%85%A2%E1%84%87%E1%85%A7%E1%86%AF.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%A6%E1%84%82%E1%85%B2.mp4",
    "https://signordermenu.s3.ap-northeast-2.amazonaws.com/%E1%84%92%E1%85%A1%E1%84%82%E1%85%A1%E1%84%8B%E1%85%B4+%E1%84%86%E1%85%A6%E1%84%82%E1%85%B2+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%82%E1%85%AE%E1%84%85%E1%85%B3%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%A6%E1%84%82%E1%85%B2.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%A5%E1%86%AF%E1%84%86%E1%85%A7%E1%86%BC.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%A1%E1%86%AF%E1%84%91%E1%85%A7%E1%84%87%E1%85%A9%E1%84%83%E1%85%A1%2C%20%E1%84%89%E1%85%A1%E1%86%AF%E1%84%91%E1%85%B5%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%84%86%E1%85%AE%E1%86%AB.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%80%E1%85%A1%E1%84%82%E1%85%B3%E1%86%BC%2C%20%E1%84%92%E1%85%A1%E1%86%AF%E1%84%89%E1%85%AE%E1%84%8B%E1%85%B5%E1%86%BB%E1%84%83%E1%85%A1.mp4",

    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%84%86%E1%85%AE%E1%86%AB.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%A9%E1%86%BC%E1%84%85%E1%85%AD%2C%20%E1%84%81%E1%85%B3%E1%87%80%E1%84%82%E1%85%A1%E1%84%83%E1%85%A1%2C%20%E1%84%86%E1%85%A1%E1%84%8E%E1%85%B5%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%84%E1%85%A9.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%84%86%E1%85%AE%E1%86%AB.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%A1%E1%86%BC%E1%84%90%E1%85%A2%2C%20%E1%84%89%E1%85%A1%E1%86%BC%E1%84%92%E1%85%AA%E1%86%BC.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%A1%E1%86%AF%E1%84%91%E1%85%A7%E1%84%87%E1%85%A9%E1%84%83%E1%85%A1%2C%20%E1%84%89%E1%85%A1%E1%86%AF%E1%84%91%E1%85%B5%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%AF%E1%86%AB%E1%84%92%E1%85%A1%E1%84%83%E1%85%A1%2C%20%E1%84%87%E1%85%A1%E1%84%85%E1%85%A1%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A9%E1%84%85%E1%85%B3%E1%86%AB%E1%84%8D%E1%85%A9%E1%86%A8.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%B1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%82%E1%85%AE%E1%84%85%E1%85%B3%E1%84%83%E1%85%A1.mp4",
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
