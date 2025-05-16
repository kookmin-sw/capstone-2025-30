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
    flex: 1,
    display: "flex",
    flexDirection: "row",
    flexWrap: "wrap",
    alignContent: "space-evenly",
    marginTop: 30,
  },
  categoryButton: {
    ...CustomStyles.fontHead20,
    width: "45%",
    aspectRatio: "1.3",
    backgroundColor: CustomStyles.primaryGray,
    color: CustomStyles.primaryBlack,
    borderRadius: 16,
    border: "none",
    cursor: "pointer",
    display: "flex",
    flexDirection: "column",
    justifyContent: "center",
    alignItems: "center",
    margin: "0 2% 5% 2%",
  },
};

export default CategoryStyles;
