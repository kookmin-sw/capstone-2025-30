import React, { createContext, useContext, useState } from "react";

const CartContext = createContext();

export const useCart = () => useContext(CartContext);

export const CartProvider = ({ children }) => {
  const [cartItems, setCartItems] = useState([]);
  const [isDineIn, setIsDineIn] = useState(null);

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
          quantity: updatedItems[index].quantity + 1,
        };
        // console.log(updatedItems);
        return updatedItems;
      } else {
        // console.log([...prev, item]);
        return [...prev, item];
      }
    });
  };

  const removeFromCart = (index) => {
    setCartItems((prev) => prev.filter((_, i) => i !== index));
  };

  const clearCart = () => {
    setCartItems([]);
  };

  //   useEffect(() => {
  //     console.log(isDineIn);
  //   }, [isDineIn]);

  return (
    <CartContext.Provider
      value={{
        isDineIn,
        setIsDineIn,
        cartItems,
        addToCart,
        removeFromCart,
        clearCart,
      }}
    >
      {children}
    </CartContext.Provider>
  );
};
