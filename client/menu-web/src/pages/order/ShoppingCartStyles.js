import CustomStyles from "@/styles/CustomStyles";

const ShoppingCartStyles = {
  container: {
    padding: "0 30px",
  },
  line: {
    width: "100%",
    height: 1.5,
    backgroundColor: CustomStyles.primaryGray,
    margin: "25px 0 25px 0",
  },
  textTotalMoney: {
    ...CustomStyles.fontHead28,
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    color: CustomStyles.primaryBlack,
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
  textPrice: {
    ...CustomStyles.fontHead24,
    color: CustomStyles.primaryBlack,
  },
  textEmpty: {
    fontSize: 20,
    lineHeight: "28px",
    fontFamily: "Pretendard",
    fontWeight: 400,
    color: CustomStyles.primaryBlack,
    textAlign: "center",
    marginTop: "15vh",
  },
};

export default ShoppingCartStyles;
