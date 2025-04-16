import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";

import MenuStyles from "@/pages/order/MenuStyles";

import { getMenu } from "../../config/api";
import { useCart } from "../../context/CartContext";
import Header from "@/components/Header";
import ButtonMenu from "@/components/ButtonMenu";
import BottomCart from "@/components/BottomCart";

const MenuPage = () => {
  const { categoryPath } = useParams();
  const { cartItems } = useCart();
  const [menus, setMenus] = useState([]);

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

      {menus && menus.length > 0 ? (
        <div
          style={{
            ...MenuStyles.container,
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
