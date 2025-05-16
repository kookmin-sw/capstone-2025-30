import { useRef, useState } from "react";
import CustomStyles from "@/styles/CustomStyles";

const BottomSheet = ({ onClose, children }) => {
  const sheetRef = useRef(null);
  const startY = useRef(null);
  const [translateY, setTranslateY] = useState(0);
  const [isDragging, setIsDragging] = useState(false);

  const handleTouchStart = (e) => {
    startY.current = e.touches[0].clientY;
    setIsDragging(true);
  };

  const handleTouchMove = (e) => {
    if (!isDragging) return;

    const currentY = e.touches[0].clientY;
    const deltaY = currentY - startY.current;

    if (deltaY > 0) {
      setTranslateY(deltaY);
    }
  };

  const handleTouchEnd = () => {
    setIsDragging(false);

    if (translateY > 100) {
      setTranslateY(600);
      setTimeout(() => {
        onClose();
        setTranslateY(0);
      }, 300);
    } else {
      setTranslateY(0);
    }
  };

  return (
    <div
      style={{
        position: "fixed",
        bottom: 0,
        left: 0,
        right: 0,
        top: 0,
        backgroundColor: "rgba(0, 0, 0, 0.5)",
        display: "flex",
        justifyContent: "center",
        alignItems: "flex-end",
        zIndex: 1000,
      }}
      onClick={onClose}
    >
      <div
        ref={sheetRef}
        style={{
          position: "relative",
          width: "100%",
          maxHeight: "80vh",
          overflowY: "auto",
          backgroundColor: CustomStyles.primaryWhite,
          borderTopLeftRadius: 24,
          borderTopRightRadius: 24,
          padding: "50px 40px 0 40px",
          transform: `translateY(${translateY}px)`,
          transition: isDragging ? "none" : "transform 0.3s ease-out",
          touchAction: "none",
        }}
        onClick={(e) => e.stopPropagation()}
        onTouchStart={handleTouchStart}
        onTouchMove={handleTouchMove}
        onTouchEnd={handleTouchEnd}
      >
        <div
          style={{
            position: "absolute",
            top: 12,
            left: "50%",
            transform: "translateX(-50%)",
            width: "15%",
            height: 4,
            borderRadius: 2,
            backgroundColor: CustomStyles.pointGray,
          }}
        />
        {children}
      </div>
    </div>
  );
};

export default BottomSheet;
