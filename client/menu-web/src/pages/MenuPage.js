import React from "react";
import { useParams } from "react-router-dom";

import MenuStyles from "@/pages/MenuStyles";

import Header from "@/components/Header";
import ButtonMenu from "@/components/ButtonMenu";

const MenuPage = () => {
  const { categoryKey } = useParams();

  const menu = [
    { text: "아메리카노", price: "4500", to: "/detailed-menu/coffee/0" },
    { text: "카페라떼", price: "4500", to: "/detailed-menu/coffee/1" },
    { text: "콜드브루", price: "4500", to: "/detailed-menu/coffee/2" },
  ];

  return (
    <div>
      {categoryKey === "coffee" && (
        <div>
          <Header centerIcon="☕️" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <ButtonMenu key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "tea" && (
        <div>
          <Header centerIcon="🌿" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <ButtonMenu key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "drink" && (
        <div>
          <Header centerIcon="🧋" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <ButtonMenu key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "cake" && (
        <div>
          <Header centerIcon="🍰" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <ButtonMenu key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "bread" && (
        <div>
          <Header centerIcon="🥯" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <ButtonMenu key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "salad" && (
        <div>
          <Header centerIcon="🥗" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <ButtonMenu key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

export default MenuPage;
