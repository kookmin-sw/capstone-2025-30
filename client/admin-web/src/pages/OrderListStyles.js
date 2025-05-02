import CustomStyles from "@/styles/CustomStyles";

const OrderListStyles = {
  container: {
    backgroundColor: CustomStyles.backgroundBlue,
    height: "100vh",
    display: "flex",
    flexDirection: "column",
    gap: 24,
  },
  gradientInputBar: {
    background:
      "linear-gradient(to bottom, rgb(221, 232, 253),  rgba(235, 242, 253, 0.0))",
    padding: "20px 30px 0 30px",
  },
  tab: {
    ...CustomStyles.fontHead20,
    flex: 1,
    backgroundColor: "transparent",
    border: "none",
    padding: "12px 0",
    cursor: "pointer",
    textAlign: "center",
    height: "60px",
  },
  tabContent: {
    padding: "20px 30px",
    backgroundColor: CustomStyles.backgroundBlue,
  },
};

export default OrderListStyles;
