import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";

import { useCart } from "../context/CartContext";
import { ReactComponent as IconCart } from "@/assets/icons/cart-colorless.svg";

const BottomCart = () => {
  const navigate = useNavigate();
  const { cartItems } = useCart();
  const [translateY, setTranslateY] = useState(100);

  const totalMoney = cartItems.reduce(
    (sum, item) => sum + item.menu_price * item.quantity,
    0
  );

  useEffect(() => {
    setTranslateY(0);
  }, []);

  const styles = {
    container: {
      position: "fixed",
      bottom: 0,
      left: 0,
      right: 0,
      transform: `translateY(${translateY}px)`,
      transition: "transform 0.3s ease-in-out",
      display: "flex",
      justifyContent: "space-between",
      alignItems: "center",
      padding: "0 20px",
      height: 60,
      backgroundColor: CustomStyles.primaryWhite,
      borderTopLeftRadius: 24,
      borderTopRightRadius: 24,
      boxShadow: "0px 0px 4px rgba(0, 0, 0, 0.3)",
      zIndex: 100,
    },
    textTotalMoney: {
      ...CustomStyles.fontSub20,
      color: CustomStyles.primaryBlack,
    },
    button: {
      ...CustomStyles.fontHead16,
      height: 40,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      padding: "12px",
      backgroundColor: CustomStyles.primaryBlue,
      color: CustomStyles.primaryWhite,
      borderRadius: 16,
      cursor: "pointer",
      border: "none",
    },
    quantityCircle: {
      ...CustomStyles.fontCaption,
      fontWeight: 700,
      width: 16,
      height: 16,
      backgroundColor: CustomStyles.primaryWhite,
      color: CustomStyles.primaryBlue,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      borderRadius: "50%",
    },
  };

  return (
    <div style={styles.container}>
      <div style={styles.textTotalMoney}>{totalMoney}원</div>
      <button style={styles.button} onClick={() => navigate("/shopping-cart")}>
        <div style={{ marginRight: 8, marginTop: 5 }}>
          <IconCart width={18} />
        </div>
        <div style={{ marginRight: 8 }}>장바구니 이동</div>
        <div style={styles.quantityCircle}>
          {cartItems.reduce((sum, item) => sum + item.quantity, 0)}
        </div>
      </button>
    </div>
  );
};

export default BottomCart;
