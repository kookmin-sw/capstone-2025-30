import CustomStyles from "@/styles/CustomStyles";

const CheckOrderNumberStyles = {
  container: {
    padding: "0 30px",
  },
  containerRow: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  inputOrderNumber: {
    ...CustomStyles.fontHead28,
    textAlign: "center",
    padding: "8px 0",
    width: "100%",
    border: "none",
    borderBottom: "1px solid #969696",
    outline: "none",
    margin: "20px 0 40px 0",
  },
};

export default CheckOrderNumberStyles;
