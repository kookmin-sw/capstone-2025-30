import React, { createContext, useContext, useState, useEffect } from "react";

const CartContext = createContext();

export const useCart = () => useContext(CartContext);

export const CartProvider = ({ children }) => {
  const [cartItems, setCartItems] = useState([]);
  const [isDiveIn, setIsDiveIn] = useState(null);

  const addToCart = (item) => {
    setCartItems((prev) => {
      const index = prev.findIndex(
        (cartItem) =>
          cartItem.category === item.category &&
          cartItem.name === item.name &&
          cartItem.menu_price === item.menu_price &&
          cartItem.temp === item.temp &&
          cartItem.size === item.size
      );

      if (index !== -1) {
        const updatedItems = [...prev];
        updatedItems[index] = {
          ...updatedItems[index],
          count: updatedItems[index].count + 1,
        };
        console.log(updatedItems);
        return updatedItems;
      } else {
        console.log([...prev, item]);
        return [...prev, item];
      }
    });
  };

  const removeFromCart = (index) => {
    setCartItems((prev) => prev.filter((_, i) => i !== index));
  };

  useEffect(() => {
    console.log(isDiveIn);
  }, [isDiveIn]);

  return (
    <CartContext.Provider
      value={{
        isDiveIn,
        setIsDiveIn,
        cartItems,
        addToCart,
        removeFromCart,
      }}
    >
      {children}
    </CartContext.Provider>
  );
};
