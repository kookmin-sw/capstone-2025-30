import CustomStyles from "@/styles/CustomStyles";

const MenuStyles = {
  container: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fill, minmax(110px, 1fr))",
    gap: 30,
    margin: "0 35px 0 35px",
    justifyItems: "center",
    alignItems: "center",
  },
  menuButton: {
    ...CustomStyles.fontSub16,
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
    color: CustomStyles.primaryBlack,
    borderRadius: 16,
    border: "none",
    cursor: "pointer",
  },
  menuButtonTextContainer: {
    position: "absolute",
    left: 0,
    right: 0,
    bottom: 0,
    width: "100%",
    height: "30%",
    backgroundColor: CustomStyles.primaryBlue,
    color: CustomStyles.primaryWhite,
    display: "flex",
    flexDirection: "column",
    justifyContent: "center",
    alignItems: "center",
  },
};

export default MenuStyles;
