import CustomStyles from "@/styles/CustomStyles";

const DetailedMenuStyles = {
  container: {
    padding: "0 30px",
  },
  containerRow: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  menuImage: {
    position: "relative",
    overflow: "hidden",
    display: "flex",
    justifyContent: "center",
    alignItems: "flex-end",
    minWidth: 140,
    height: 164,
    backgroundSize: "cover",
    backgroundRepeat: "no-repeat",
    backgroundPosition: "center",
    borderRadius: 16,
  },
  textMenu: {
    ...CustomStyles.fontHead18,
    color: CustomStyles.primaryBlack,
    margin: "0 0 0 16px",
  },
  line: {
    width: "100%",
    height: 1.5,
    backgroundColor: CustomStyles.primaryGray,
    margin: "24px 0",
  },
  textDescription: {
    ...CustomStyles.fontCaption,
    color: CustomStyles.pointGray,
    margin: "10px 0 0 16px",
  },
};

export default DetailedMenuStyles;
