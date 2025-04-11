import CustomStyles from "@/styles/CustomStyles";

const HomeStyles = {
  container: {
    padding: "0 30px",
  },
  headerIcon: {
    fontSize: 48,
    lineHeight: "56px",
    textAlign: "center",
  },
  orderButton: {
    ...CustomStyles.fontHead28,
    width: "100%",
    height: 230,
    backgroundColor: CustomStyles.primaryGray,
    color: CustomStyles.primaryBlack,
    borderRadius: 16,
    border: "none",
    cursor: "pointer",
    marginBottom: 25,
  },
};

export default HomeStyles;
