import axios from "axios";

export const api = axios.create({
  baseURL: process.env.REACT_APP_API_URL,
  headers: {
    "Content-type": "application/json",
    "api-key": process.env.REACT_APP_API_KEY,
  },
});

export const getCategory = () => {
  return api.get("/rest/menu/5fjVwE8z/category");
};

export const getMenu = (category) => {
  return api.get(`/rest/menu/5fjVwE8z/menuList?category=${category}`);
};

export const getDetailMenu = (category, menu) => {
  return api.get(
    `/rest/menu/5fjVwE8z/menuDetail?category=${category}&name=${menu}`
  );
};

export const createOrder = (orderData) => {
  return api.post("/rest/order/5fjVwE8z", orderData);
};

export const getOrderNumber = (orderNumber) => {
  return api.get(`/rest/order/5fjVwE8z/${orderNumber}`);
};
