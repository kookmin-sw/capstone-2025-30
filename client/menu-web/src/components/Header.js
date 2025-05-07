import React from "react";
import { useNavigate } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";

import { useCart } from "../context/CartContext";
import { ReactComponent as IconBack } from "@/assets/icons/back.svg";
import { ReactComponent as IconCart } from "@/assets/icons/cart.svg";

const Header = ({ centerIcon, cartIcon, goTo = null }) => {
  const navigate = useNavigate();
  const { cartItems } = useCart();

  const goBack = () => {
    if (goTo) {
      navigate(goTo);
    } else {
      navigate(-1);
    }
  };

  const styles = {
    container: {
      display: "flex",
      alignItems: "center",
      justifyContent: "space-between",
      padding: "0px 20px 0 20px",
      height: 96,
    },
    centerIcon: {
      position: "absolute",
      left: "50%",
      transform: "translateX(-50%)",
      fontSize: 48,
      lineHeight: "56px",
    },
    button: {
      position: "relative",
      background: "none",
      border: "none",
      cursor: "pointer",
    },
    quantityCircle: {
      ...CustomStyles.fontCaption,
      fontWeight: 700,
      position: "absolute",
      top: -2,
      right: 0,
      display: "flex",
      justifyContent: "center",
      alignItems: "center",
      width: 16,
      height: 16,
      backgroundColor: CustomStyles.pointRed,
      color: CustomStyles.primaryWhite,

      borderRadius: "50%",
    },
  };

  return (
    <div style={styles.container}>
      <button style={styles.button} onClick={goBack}>
        <IconBack />
      </button>

      {centerIcon && <div style={styles.centerIcon}>{centerIcon}</div>}

      {cartIcon !== null && (
        <button
          style={styles.button}
          onClick={() => navigate("/shopping-cart")}
        >
          {cartItems.length > 0 && (
            <div style={styles.quantityCircle}>
              {cartItems.reduce((sum, item) => sum + item.quantity, 0)}
            </div>
          )}
          <IconCart />
        </button>
      )}
    </div>
  );
};

export default Header;
