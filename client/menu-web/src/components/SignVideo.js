import React, { useRef, useState } from "react";

import CustomStyles from "@/styles/CustomStyles";
import { ReactComponent as IconReload } from "@/assets/icons/reload.svg";

const SignVideo = ({ srcList = [], onVideoEnd }) => {
  const videoRef = useRef(null);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isEnded, setIsEnded] = useState(false);

  const handleReplay = () => {
    setIsEnded(false);
    setCurrentIndex(0);
  };

  const handleEnded = () => {
    if (currentIndex < srcList.length - 1) {
      setCurrentIndex(currentIndex + 1);
    } else {
      setIsEnded(true);
      if (typeof onVideoEnd === "function") {
        onVideoEnd();
      }
    }
  };

  return (
    <div
      style={{
        position: "relative",
        width: "100%",
        paddingTop: "100%",
        backgroundColor: isEnded && "rgba(0,0,0,0.7)",
        borderRadius: 16,
        pointerEvents: "none",
      }}
    >
      <video
        ref={videoRef}
        src={srcList[currentIndex]}
        style={{
          position: "absolute",
          top: 0,
          left: 0,
          width: "100%",
          height: "100%",
          objectFit: "cover",
          borderRadius: 16,
        }}
        autoPlay
        muted
        playsInline
        webkit-playsinline="true"
        x5-playsinline="true"
        x5-video-player-type="h5"
        onEnded={handleEnded}
      />
      {isEnded && (
        <>
          <div
            style={{
              position: "absolute",
              top: 0,
              left: 0,
              width: "100%",
              height: "100%",
              backgroundColor: "rgba(0, 0, 0, 0.7)",
              borderRadius: 16,
              zIndex: 1,
            }}
          />
          <button
            onClick={handleReplay}
            style={{
              position: "absolute",
              top: "50%",
              left: "50%",
              transform: "translate(-50%, -50%)",
              backgroundColor: "transparent",
              padding: "12px 20px",
              border: "none",
              cursor: "pointer",
              zIndex: 2,
            }}
          >
            <IconReload
              width="76"
              height="76"
              fill={CustomStyles.primaryWhite}
            />
          </button>
        </>
      )}
    </div>
  );
};

export default SignVideo;
