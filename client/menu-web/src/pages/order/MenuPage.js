import React, { useState, useEffect } from "react";
import { useParams, useLocation } from "react-router-dom";

import MenuStyles from "@/pages/order/MenuStyles";

import { getMenu } from "../../config/api";
import Header from "@/components/Header";
import ButtonMenu from "@/components/ButtonMenu";

const MenuPage = () => {
  const { categoryPath } = useParams();
  const { state } = useLocation();
  const [menus, setMenus] = useState([]);
  const [showCartModal, setShowCartModal] = useState(false);

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

  useEffect(() => {
    if (state?.cartModal) {
      setShowCartModal(true);
      const timer = setTimeout(() => {
        setShowCartModal(false);
      }, 2000);
      return () => clearTimeout(timer);
    }
  }, [state]);

  return (
    <div style={{ marginBottom: 40 }}>
      {categoryPath === "커피" && <Header centerIcon="☕️" />}
      {categoryPath === "차" && <Header centerIcon="🌿" />}
      {categoryPath === "음료" && <Header centerIcon="🧋" />}
      {categoryPath === "케이크" && <Header centerIcon="🍰" />}
      {categoryPath === "빵" && <Header centerIcon="🥯" />}
      {categoryPath === "샐러드" && <Header centerIcon="🥗" />}

      {menus && menus.length > 0 ? (
        <div style={{ ...MenuStyles.container }}>
          {menus.map((item, idx) => (
            <ButtonMenu key={idx} menu={item} />
          ))}
        </div>
      ) : (
        <></>
      )}

      {showCartModal && (
        <div style={{ ...MenuStyles.modalCart }}>장바구니에 담겼습니다!</div>
      )}
    </div>
  );
};

export default MenuPage;
