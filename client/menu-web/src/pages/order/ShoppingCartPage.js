import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import ShoppingCartStyles from "@/pages/order/ShoppingCartStyles";

import Header from "@/components/Header";
import ButtonMenu from "@/components/ButtonMenu";
import { useCart } from "../../context/CartContext";
import { createOrder } from "../../config/api";
import { ReactComponent as IconDelete } from "@/assets/icons/delete.svg";
import { ReactComponent as IconPlus } from "@/assets/icons/plus.svg";
import { ReactComponent as IconSubtraction } from "@/assets/icons/subtraction.svg";
import { ReactComponent as IconCold } from "@/assets/icons/cold.svg";
import { ReactComponent as IconHot } from "@/assets/icons/hot.svg";
import { ReactComponent as IconSize } from "@/assets/icons/size.svg";
import { ReactComponent as IconCheck } from "@/assets/icons/check.svg";
import Button from "@/components/Button";
import BottomSheet from "@/components/BottomSheet";
import SignVideo from "@/components/SignVideo";
import ButtonYesNo from "@/components/ButtonYesNo";

const CartList = ({ menu, isLast, onIncrease, onDecrease, onDelete }) => {
  return (
    <div>
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
          <div onClick={onDelete} style={{ cursor: "pointer" }}>
            <IconDelete />
          </div>

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
              {menu.temp === "차갑게" ? (
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
                  {menu.size === "적게"
                    ? "S"
                    : menu.size === "보통"
                    ? "M"
                    : "L"}
                </div>
                <IconSize width={30} height={32.73} />
              </div>
            </div>

            <div style={{ ...ShoppingCartStyles.textPrice, margin: "4px 0" }}>
              {menu.menu_price * menu.quantity}원
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
                {menu.quantity}
              </div>
              <div onClick={onIncrease} style={{ cursor: "pointer" }}>
                <IconPlus />
              </div>
            </div>
          </div>
        </div>
      </div>
      {!isLast ? (
        <div style={ShoppingCartStyles.line} />
      ) : (
        <div style={{ height: 70 }} />
      )}
    </div>
  );
};

const ShoppingCartPage = () => {
  const navigate = useNavigate();
  const { cartItems, removeFromCart, clearCart } = useCart();
  const [isBottomSheetOpen, setIsBottomSheetOpen] = useState(false);
  const [menu, setMenu] = useState(cartItems);

  const videos = [
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A7%E1%84%80%E1%85%B5.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%A5%E1%86%A8%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AF%E1%84%8B%E1%85%B3%E1%86%B7%E1%84%91%E1%85%AD.mp4",
  ];

  useEffect(() => {
    setMenu(cartItems);
  }, [cartItems]);

  const handleIncrease = (index) => {
    const newMenus = [...menu];
    newMenus[index].quantity += 1;
    setMenu(newMenus);
  };

  const handleDecrease = (index) => {
    const newMenus = [...menu];
    if (newMenus[index].quantity > 1) {
      newMenus[index].quantity -= 1;
      setMenu(newMenus);
    }
  };

  const handleDelete = (index) => {
    removeFromCart(index);
  };

  const totalMoney = menu.reduce(
    (sum, item) => sum + item.menu_price * item.quantity,
    0
  );

  const fetchCreateOrder = async (isDineIn) => {
    try {
      const orderData = {
        dine_in: isDineIn,
        total_price: totalMoney,
        items: cartItems.map((item) => ({
          name: item.name,
          quantity: item.quantity,
          options: {
            choices: {
              temperature: item.temp,
              size: item.size,
            },
          },
          item_price: item.menu_price,
        })),
      };

      console.log(orderData);
      const category = await createOrder(orderData);
      clearCart();
      navigate("/order-number", {
        state: { orderNumber: category.data.order_number },
      });
    } catch (error) {
      console.error(
        "주문 생성 오류:",
        error.response ? error.response.data : error.message
      );
    }
  };

  return (
    <div>
      <Header centerIcon={null} cartIcon={null} />

      <div style={ShoppingCartStyles.container}>
        <div style={ShoppingCartStyles.textTotalMoney}>
          <div style={{ fontSize: 44, lineHeight: "52px" }}>💵</div>
          <div>{totalMoney}원</div>
        </div>

        <div style={{ ...ShoppingCartStyles.line, height: 5 }} />

        <div
          style={{
            display: "flex",
            flexDirection: "column",
            justifyContent: "space-between",
            height: "70vh",
          }}
        >
          {cartItems.length !== 0 ? (
            <>
              {menu.map((item, idx) => (
                <CartList
                  key={idx}
                  menu={item}
                  isLast={idx === cartItems.length - 1}
                  onIncrease={() => handleIncrease(idx)}
                  onDecrease={() => handleDecrease(idx)}
                  onDelete={() => handleDelete(idx)}
                />
              ))}
            </>
          ) : (
            <div style={ShoppingCartStyles.textEmpty}>
              장바구니가 비었습니다.
            </div>
          )}

          <Button
            icon={<IconCheck />}
            text="주문하기"
            disabled={cartItems.length === 0}
            onClick={() => {
              cartItems.length !== 0 && setIsBottomSheetOpen(true);
            }}
          />
        </div>

        {isBottomSheetOpen && (
          <BottomSheet onClose={() => setIsBottomSheetOpen(false)}>
            {/* 드시고가실건가요 */}
            <SignVideo srcList={videos} />
            <div style={{ margin: "24px 0 24px 0" }}>
              <ButtonYesNo
                pressYes={() => {
                  fetchCreateOrder(true);
                }}
                pressNo={() => {
                  fetchCreateOrder(false);
                }}
              />
            </div>
          </BottomSheet>
        )}
      </div>
    </div>
  );
};

export default ShoppingCartPage;
