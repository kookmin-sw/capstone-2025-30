import CustomStyles from "@/styles/CustomStyles";

const OrderProcessStyles = {
  container: {
    padding: "0 30px",
  },
  line: {
    width: "100%",
    height: 1.5,
    backgroundColor: CustomStyles.primaryGray,
    margin: "25px 0",
  },
  textProcess: {
    ...CustomStyles.fontHead28,
    color: CustomStyles.primaryBlack,
    margin: "15px 0 30px 0",
    textAlign: "center",
  },
  textSize: {
    ...CustomStyles.fontSub16,
    fontWeight: "bold",
    position: "absolute",
    left: "50%",
    transform: "translateX(-50%)",
    marginBottom: 10,
    color: CustomStyles.pointGray,
  },
};

export default OrderProcessStyles;
