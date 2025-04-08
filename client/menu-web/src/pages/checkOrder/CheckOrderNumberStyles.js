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
  menuButton: {
    position: "relative",
    overflow: "hidden",
    display: "flex",
    justifyContent: "center",
    alignItems: "flex-end",
    width: 140,
    height: 164,
    backgroundSize: "cover",
    backgroundRepeat: "no-repeat",
    backgroundPosition: "center",
    borderRadius: 16,
  },
  textMenu: {
    ...CustomStyles.fontHead28,
  },
  line: {
    width: "100%",
    height: 1.5,
    backgroundColor: CustomStyles.primaryGray,
    margin: "25px 0 25px 0",
  },
};

export default CheckOrderNumberStyles;
