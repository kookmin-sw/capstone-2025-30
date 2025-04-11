import React, { useState } from "react";
import { useParams } from "react-router-dom";

import DetailedMenuStyles from "@/pages/order/DetailedMenuStyles";

import Header from "@/components/Header";
import coffeeImage from "@/assets/images/image-coffee.png";
import { ReactComponent as IconCold } from "@/assets/icons/cold.svg";
import { ReactComponent as IconHot } from "@/assets/icons/hot.svg";
import { ReactComponent as IconSize } from "@/assets/icons/size.svg";
import { ReactComponent as IconShoppingCart } from "@/assets/icons/shopping-cart.svg";
import ButtonTemperature from "@/components/ButtonTemperature";
import ButtonSize from "@/components/ButtonSize";
import Button from "@/components/Button";

const DetailedMenuPage = () => {
  const { categoryKey } = useParams();
  const [selectedTemp, setSelectedTemp] = useState("차갑게");
  const [selectedSize, setSelectedSize] = useState("적게");

  return (
    <div>
      {categoryKey === "coffee" && <Header centerIcon="☕️" />}
      {categoryKey === "tea" && <Header centerIcon="🌿" />}
      {categoryKey === "drink" && <Header centerIcon="🧋" />}
      {categoryKey === "cake" && <Header centerIcon="🍰" />}
      {categoryKey === "bread" && <Header centerIcon="🥯" />}
      {categoryKey === "salad" && <Header centerIcon="🥗" />}

      <div style={{ ...DetailedMenuStyles.container }}>
        <div
          style={{
            ...DetailedMenuStyles.containerRow,
          }}
        >
          <div
            style={{
              ...DetailedMenuStyles.menuButton,
              backgroundImage: `url(${coffeeImage})`, // 추후 이미지 링크로 변경
            }}
          ></div>
          <div style={{ display: "flex", flexDirection: "column" }}>
            <div style={{ ...DetailedMenuStyles.textMenu }}>아메리카노</div>
            <div style={{ ...DetailedMenuStyles.textMenu }}>4,500원</div>
          </div>
        </div>

        <div style={{ ...DetailedMenuStyles.line }} />

        <div
          style={{
            width: "100%",
            paddingTop: "100%",
            backgroundColor: "#D0D0D0",
            borderRadius: 16,
          }}
        />

        <div style={{ ...DetailedMenuStyles.line }} />

        <div style={{ ...DetailedMenuStyles.containerRow }}>
          <ButtonTemperature
            icon={<IconCold />}
            text="차갑게"
            isSelected={selectedTemp === "차갑게"}
            onClick={() => setSelectedTemp("차갑게")}
          />
          <ButtonTemperature
            icon={<IconHot />}
            text="뜨겁게"
            isSelected={selectedTemp === "뜨겁게"}
            onClick={() => setSelectedTemp("뜨겁게")}
          />
        </div>

        <div style={{ ...DetailedMenuStyles.containerRow }}>
          <ButtonSize
            size="S"
            icon={<IconSize width={32} height={34.91} />}
            text="적게"
            isSelected={selectedSize === "적게"}
            onClick={() => setSelectedSize("적게")}
          />
          <ButtonSize
            size="M"
            icon={<IconSize width={36} height={39.27} />}
            text="보통"
            isSelected={selectedSize === "보통"}
            onClick={() => setSelectedSize("보통")}
          />
          <ButtonSize
            size="L"
            icon={<IconSize width={40} height={43.63} />}
            text="많이"
            isSelected={selectedSize === "많이"}
            onClick={() => setSelectedSize("많이")}
          />
        </div>

        <Button
          icon={<IconShoppingCart />}
          text="장바구니 담기"
          onClick={() => {}}
        />
      </div>
    </div>
  );
};

export default DetailedMenuPage;
