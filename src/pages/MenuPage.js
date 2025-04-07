import React, { useState } from "react";
import { useParams, useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import MenuStyles from "@/pages/MenuStyles";

import Header from "@/components/Header";
import coffeeImage from "@/assets/images/image-coffee.png";

const MenuButton = ({ menu }) => {
  const [isPressed, setIsPressed] = useState(false);
  const navigate = useNavigate();

  const handlePressIn = () => setIsPressed(true);
  const handlePressOut = () => setIsPressed(false);
  const handleClick = () => navigate(menu.to);

  return (
    <button
      onMouseDown={handlePressIn}
      onMouseUp={handlePressOut}
      onMouseLeave={handlePressOut}
      onTouchStart={handlePressIn}
      onTouchEnd={handlePressOut}
      onClick={handleClick}
      style={{
        ...MenuStyles.menuButton,
        backgroundColor: isPressed
          ? CustomStyles.primaryBlue
          : CustomStyles.primaryGray,
        color: isPressed
          ? CustomStyles.primaryWhite
          : CustomStyles.primaryBlack,
        backgroundImage: `url(${coffeeImage})`, // 추후 이미지 링크로 변경
      }}
    >
      <div
        style={{
          ...MenuStyles.menuButtonTextContainer,
          backgroundColor: isPressed
            ? CustomStyles.primaryBlue
            : CustomStyles.primaryGray,
          color: isPressed
            ? CustomStyles.primaryWhite
            : CustomStyles.primaryBlack,
        }}
      >
        <div>{menu.text}</div>
        <div>{menu.price}원</div>
      </div>
    </button>
  );
};

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
              <MenuButton key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "tea" && (
        <div>
          <Header centerIcon="🌿" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <MenuButton key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "drink" && (
        <div>
          <Header centerIcon="🧋" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <MenuButton key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "cake" && (
        <div>
          <Header centerIcon="🍰" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <MenuButton key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "bread" && (
        <div>
          <Header centerIcon="🥯" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <MenuButton key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}

      {categoryKey === "salad" && (
        <div>
          <Header centerIcon="🥗" />
          <div style={{ ...MenuStyles.container }}>
            {menu.map((menu, idx) => (
              <MenuButton key={idx} menu={menu} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

export default MenuPage;
