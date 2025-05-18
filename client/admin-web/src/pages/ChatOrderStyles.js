import CustomStyles from "@/styles/CustomStyles";

const ChatOrderStyles = {
  container: {
    backgroundColor: CustomStyles.backgroundBlue,
    height: "100vh",
  },
  chatBubble: {
    backgroundColor: CustomStyles.backgroundBlue,
    flex: 1,
  },
  bottomContainer: {
    position: "fixed",
    bottom: 0,
    padding: "15px 20px",
    background:
      "linear-gradient(to top, rgb(221, 232, 253), rgb(235, 242, 253), rgb(235, 242, 253), rgba(235, 242, 253, 0.0))",
  },
};

export default ChatOrderStyles;
