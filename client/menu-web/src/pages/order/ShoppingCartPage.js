import React, { useState } from "react";

import CustomStyles from "@/styles/CustomStyles";
import ShoppingCartStyles from "@/pages/order/ShoppingCartStyles";

import Header from "@/components/Header";
import ButtonMenu from "@/components/ButtonMenu";
import { ReactComponent as IconDelete } from "@/assets/icons/delete.svg";
import { ReactComponent as IconPlus } from "@/assets/icons/plus.svg";
import { ReactComponent as IconSubtraction } from "@/assets/icons/subtraction.svg";
import { ReactComponent as IconCold } from "@/assets/icons/cold.svg";
import { ReactComponent as IconHot } from "@/assets/icons/hot.svg";
import { ReactComponent as IconSize } from "@/assets/icons/size.svg";
import { ReactComponent as IconCheck } from "@/assets/icons/check.svg";
import Button from "@/components/Button";
import BottomSheet from "@/components/BottomSheet";
import ButtonYesNo from "@/components/ButtonYesNo";

const CartList = ({ menu, isLast, onIncrease, onDecrease }) => {
  return (
    <>
      <div
        style={{
          display: "flex",
          flexDirection: "row",
          justifyContent: "space-between",
        }}
      >
        <ButtonMenu menu={menu} isNull={true} />
        <div
          style={{
            display: "flex",
            flexDirection: "column",
            justifyContent: "space-between",
            alignItems: "flex-end",
          }}
        >
          <IconDelete />

          <div
            style={{
              display: "flex",
              flexDirection: "column",
              alignItems: "flex-end",
              margin: 10,
            }}
          >
            <div
              style={{
                display: "flex",
                alignItems: "center",
              }}
            >
              {menu.temp === "ice" ? (
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
                <div
                  style={{ ...ShoppingCartStyles.textSize, margin: "8px 0" }}
                >
                  {menu.size}
                </div>
                <IconSize width={30} height={32.73} />
              </div>
            </div>

            <div style={{ ...ShoppingCartStyles.textPrice, margin: "4px 0" }}>
              {menu.price * menu.count}원
            </div>

            <div
              style={{
                display: "flex",
                flexDirection: "row",
                alignItems: "center",
              }}
            >
              <div onClick={onDecrease} style={{ cursor: "pointer" }}>
                <IconSubtraction />
              </div>
              <div
                style={{ ...ShoppingCartStyles.textPrice, margin: "0 20px" }}
              >
                {menu.count}
              </div>
              <div onClick={onIncrease} style={{ cursor: "pointer" }}>
                <IconPlus />
              </div>
            </div>
          </div>
        </div>
      </div>
      {!isLast ? (
        <div style={{ ...ShoppingCartStyles.line }} />
      ) : (
        <div style={{ height: 70 }} />
      )}
    </>
  );
};

const ShoppingCartPage = () => {
  const [isBottomSheetOpen, setIsBottomSheetOpen] = useState(false);

  const [menu, setMenu] = useState([
    { text: "아메리카노", price: 4500, temp: "ice", size: "S", count: 1 },
    { text: "카페라떼", price: 4500, temp: "hot", size: "L", count: 1 },
    { text: "콜드브루", price: 4500, temp: "ice", size: "M", count: 1 },
  ]);

  const handleIncrease = (index) => {
    const newMenus = [...menu];
    newMenus[index].count += 1;
    setMenu(newMenus);
  };

  const handleDecrease = (index) => {
    const newMenus = [...menu];
    if (newMenus[index].count > 1) {
      newMenus[index].count -= 1;
      setMenu(newMenus);
    }
  };

  const totalMoney = menu.reduce(
    (sum, item) => sum + item.price * item.count,
    0
  );

  return (
    <div>
      <Header centerIcon={null} cartIcon={null} />

      <div style={{ ...ShoppingCartStyles.container }}>
        <div style={{ ...ShoppingCartStyles.textTotalMoney }}>
          <div style={{ fontSize: 44, lineHeight: "52px" }}>💵</div>
          <div>{totalMoney}원</div>
        </div>

        <div style={{ ...ShoppingCartStyles.line, height: 5 }} />

        {menu.map((item, idx) => (
          <CartList
            key={idx}
            menu={item}
            isLast={idx === menu.length - 1}
            onIncrease={() => handleIncrease(idx)}
            onDecrease={() => handleDecrease(idx)}
          />
        ))}

        <Button
          icon={<IconCheck />}
          text="주문하기"
          onClick={() => {
            setIsBottomSheetOpen(true);
          }}
        />

        {isBottomSheetOpen && (
          <BottomSheet onClose={() => setIsBottomSheetOpen(false)}>
            <div
              style={{
                width: "100%",
                paddingTop: "100%",
                backgroundColor: "#D0D0D0",
                borderRadius: 16,
              }}
            />
            <div style={{ margin: "24px 0 24px 0" }}>
              <ButtonYesNo pressNo={() => setIsBottomSheetOpen(false)} />
            </div>
          </BottomSheet>
        )}
      </div>
    </div>
  );
};

export default ShoppingCartPage;
