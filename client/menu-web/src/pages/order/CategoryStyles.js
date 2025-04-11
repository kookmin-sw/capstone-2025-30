import CustomStyles from "@/styles/CustomStyles";

const CategoryStyles = {
  container: {
    display: "flex",
    flexDirection: "row",
    flexWrap: "wrap",
    justifyContent: "center",
  },
  categoryButton: {
    ...CustomStyles.fontHead24,
    width: 140,
    height: 164,
    backgroundColor: CustomStyles.primaryGray,
    color: CustomStyles.primaryBlack,
    borderRadius: 16,
    border: "none",
    cursor: "pointer",
    margin: "0 8px 25px 8px",
  },
};

export default CategoryStyles;
