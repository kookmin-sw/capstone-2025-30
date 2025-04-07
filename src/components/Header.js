import React from "react";
import { useNavigate } from "react-router-dom";

import { ReactComponent as IconBack } from "@/assets/icons/back.svg";
import { ReactComponent as IconCart } from "@/assets/icons/cart.svg";

const Header = ({ centerIcon }) => {
  const navigate = useNavigate();

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
      background: "none",
      border: "none",
      cursor: "pointer",
    },
  };

  return (
    <div style={styles.container}>
      <button style={styles.button} onClick={() => navigate(-1)}>
        <IconBack />
      </button>

      <div style={styles.centerIcon}>{centerIcon}</div>

      <button style={styles.button}>
        <IconCart />
      </button>
    </div>
  );
};

export default Header;
