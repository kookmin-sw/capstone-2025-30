import axios from "axios";

export const api = axios.create({
  baseURL: process.env.REACT_APP_API_URL,
  headers: {
    "Content-type": "application/json",
    "api-key": process.env.REACT_APP_API_KEY,
  },
});

export const getChatRoomList = (storeCode, status) => {
  return api.get(`/rest/chat-room-list/${storeCode}`, {
    params: {
      chat_room_status: status,
    },
  });
};

export const getChatMessages = (storeCode, type, number) => {
  return api.get(`/rest/messages/${storeCode}`, {
    params: {
      notification_title: type,
      number: number,
    },
  });
};

export const modifyStatus = (storeCode, orderNumber) => {
  return api.put(`/rest/order/${storeCode}/${orderNumber}/status`, {
    status: "ORDER_DONE",
  });
};
