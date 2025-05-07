import React, { useRef, useState } from "react";

import CustomStyles from "@/styles/CustomStyles";
import { ReactComponent as IconReload } from "@/assets/icons/reload.svg";

const SignVideo = ({ src }) => {
  const videoRef = useRef(null);
  const [isEnded, setIsEnded] = useState(false);

  const handleReplay = () => {
    setIsEnded(false);
    videoRef.current.currentTime = 0;
    videoRef.current.play();
  };

  return (
    <div
      style={{
        position: "relative",
        width: "100%",
        paddingTop: "100%",
        backgroundColor: isEnded && "rgba(0,0,0,0.7)",
        borderRadius: 16,
      }}
    >
      <video
        ref={videoRef}
        src={src}
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
        onEnded={() => setIsEnded(true)}
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
