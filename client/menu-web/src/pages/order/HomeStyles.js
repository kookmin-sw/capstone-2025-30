import CustomStyles from "@/styles/CustomStyles";

const HomeStyles = {
  container: {
    padding: "0 30px",
    overflow: "hidden",
  },
  headerIcon: {
    fontSize: 48,
    lineHeight: "56px",
    textAlign: "center",
  },
  containerButton: {
    display: "flex",
    justifyContent: "space-between",
  },
  orderButton: {
    ...CustomStyles.fontHead20,
    width: "100%",
    height: 164,
    backgroundColor: CustomStyles.primaryGray,
    color: CustomStyles.primaryBlack,
    borderRadius: 16,
    border: "none",
    cursor: "pointer",
    marginTop: 30,
    marginBottom: 50,
  },
};

export default HomeStyles;
