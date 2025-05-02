import CustomStyles from "@/styles/CustomStyles";

const OrderListStyles = {
  container: {
    backgroundColor: CustomStyles.backgroundBlue,
    height: "100vh",
    display: "flex",
    flexDirection: "column",
    gap: 24,
  },
  tab: {
    ...CustomStyles.fontHead20,
    flex: 1,
    backgroundColor: "transparent",
    border: "none",
    padding: "12px 0",
    cursor: "pointer",
    textAlign: "center",
  },
};

export default OrderListStyles;
