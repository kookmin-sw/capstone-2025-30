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
    display: "grid",
    gridTemplateColumns: "repeat(auto-fill, minmax(110px, 1fr))",
    gap: 20,
    justifyItems: "center",
    alignItems: "center",
    marginTop: 30,
    width: "100%",
  },
  categoryButton: {
    ...CustomStyles.fontHead20,
    width: "100%",
    height: 100,
    backgroundColor: CustomStyles.primaryGray,
    color: CustomStyles.primaryBlack,
    borderRadius: 16,
    border: "none",
    cursor: "pointer",
    justifyContent: "center",
    alignItems: "center",
  },
};

export default CategoryStyles;
