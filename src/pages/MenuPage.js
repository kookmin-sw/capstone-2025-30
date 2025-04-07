import React, { useState } from "react";
import { useParams } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import MenuStyles from "@/pages/MenuStyles";

import Header from "@/components/Header";
import coffeeImage from "@/assets/images/image-coffee.png";

const MenuButton = ({ menu }) => {
  const [isPressed, setIsPressed] = useState(false);

  const handlePressIn = () => setIsPressed(true);
  const handlePressOut = () => setIsPressed(false);

  return (
    <button
      onMouseDown={handlePressIn}
      onMouseUp={handlePressOut}
      onMouseLeave={handlePressOut}
      onTouchStart={handlePressIn}
      onTouchEnd={handlePressOut}
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
    { text: "아메리카노", price: "4500" },
    { text: "카페라떼", price: "4500" },
    { text: "콜드브루", price: "4500" },
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
