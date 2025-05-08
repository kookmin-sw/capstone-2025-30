import CustomStyles from "@/styles/CustomStyles";

const CategoryStyles = {
  container: {
    display: "flex",
    flexDirection: "row",
    flexWrap: "wrap",
    justifyContent: "center",
    padding: "0 30px",
  },
  containerCategory: {
    marginTop: 30,
  },
  categoryButton: {
    ...CustomStyles.fontHead20,
    width: 130,
    height: 100,
    backgroundColor: CustomStyles.primaryGray,
    color: CustomStyles.primaryBlack,
    borderRadius: 16,
    border: "none",
    cursor: "pointer",
    margin: "0 10px 16px 10px ",
    justifyContent: "center",
    alignItems: "center",
  },
};

export default CategoryStyles;
