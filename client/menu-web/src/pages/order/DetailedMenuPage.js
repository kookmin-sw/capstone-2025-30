import React, { useState, useEffect, useRef } from "react";
import { useNavigate, useParams } from "react-router-dom";

import CustomStyles from "@/styles/CustomStyles";
import DetailedMenuStyles from "@/pages/order/DetailedMenuStyles";

import { getDetailMenu } from "../../config/api";
import { useCart } from "../../context/CartContext";
import Header from "@/components/Header";
import { ReactComponent as IconCold } from "@/assets/icons/cold.svg";
import { ReactComponent as IconHot } from "@/assets/icons/hot.svg";
import { ReactComponent as IconSize } from "@/assets/icons/size.svg";
import { ReactComponent as IconShoppingCart } from "@/assets/icons/shopping-cart.svg";
import { ReactComponent as IconReload } from "@/assets/icons/reload.svg";
import ButtonTemperature from "@/components/ButtonTemperature";
import ButtonSize from "@/components/ButtonSize";
import Button from "@/components/Button";

const DetailedMenuPage = () => {
  const navigate = useNavigate();
  const videoRef = useRef(null);
  const { categoryPath, menuPath } = useParams();
  const { addToCart } = useCart();
  const [detailMenu, setDetailMenu] = useState([]);
  const [selectedTemp, setSelectedTemp] = useState("차갑게");
  const [selectedSize, setSelectedSize] = useState("적게");
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isEnded, setIsEnded] = useState(false);
  const [videoList, setVideoList] = useState([]);

  useEffect(() => {
    const list1 = [
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%B0%A8%EA%B0%91%EB%8B%A4%2C%20%EC%B6%A5%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A7%88%EC%8B%9C%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8E%E1%85%A1%E1%84%80%E1%85%A1%E1%86%B8%E1%84%80%E1%85%A6+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%94%B0%EB%9C%BB%ED%95%98%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A7%88%EC%8B%9C%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%84%E1%85%A1%E1%84%84%E1%85%B3%E1%86%BA%E1%84%92%E1%85%A1%E1%84%80%E1%85%A6+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
    ];

    const list2 = [
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A1%B0%EA%B8%88%2C%20%EC%9E%91%EB%8B%A4%2C%20%EC%A0%81%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A7%88%EC%8B%9C%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%A5%E1%86%A8%E1%84%80%E1%85%A6+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B3%B4%ED%86%B5.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A7%88%EC%8B%9C%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A9%E1%84%90%E1%85%A9%E1%86%BC+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A7%8E%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%A7%88%EC%8B%9C%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%A1%E1%86%AD%E1%84%8B%E1%85%B5+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
    ];

    if (Array.isArray(detailMenu.sign_language_urls)) {
      setVideoList([...detailMenu.sign_language_urls, ...list1, ...list2]);
    }
  }, [detailMenu]);

  const handleReplay = () => {
    setIsEnded(false);
    setCurrentIndex(0);
  };

  const handleVideoEnd = () => {
    if (currentIndex < videoList.length - 1) {
      setCurrentIndex(currentIndex + 1);
    } else {
      setIsEnded(true);
    }
  };

  useEffect(() => {
    const fetchGetDetailedMenu = async () => {
      try {
        const category = await getDetailMenu(categoryPath, menuPath);
        setDetailMenu(category.data.menu);
      } catch (error) {
        console.error(
          "메뉴 상세 조회 오류:",
          error.response ? error.response.data : error.message
        );
      }
    };
    fetchGetDetailedMenu();
  }, [categoryPath, menuPath]);

  const sizeOptionPrice = () => {
    switch (selectedSize) {
      case "보통":
        return detailMenu.options?.[1]?.option_price[1];
      case "많이":
        return detailMenu.options?.[1]?.option_price[2];
      default:
        return detailMenu.options?.[1]?.option_price[0];
    }
  };

  const menuPrice = detailMenu.menu_price + sizeOptionPrice();

  const handleAddCart = () => {
    addToCart({
      category: categoryPath,
      name: menuPath,
      menu_price: menuPrice,
      temp: selectedTemp,
      size: selectedSize,
      quantity: 1,
      image: detailMenu.image,
    });
    navigate(`/menu/${categoryPath}`, {
      state: { cartModal: true },
      replace: true, // 뒤로가기 불가하도록 히스토리 스택 대체하기
    });
  };

  return (
    <>
      {categoryPath === "커피" && <Header centerIcon="☕️" />}
      {categoryPath === "차" && <Header centerIcon="🌿" />}
      {categoryPath === "음료" && <Header centerIcon="🧋" />}
      {categoryPath === "케이크" && <Header centerIcon="🍰" />}
      {categoryPath === "빵" && <Header centerIcon="🥯" />}
      {categoryPath === "샐러드" && <Header centerIcon="🥗" />}

      <div style={DetailedMenuStyles.container}>
        <div style={DetailedMenuStyles.containerRow}>
          <div
            style={{
              ...DetailedMenuStyles.menuImage,
              backgroundImage: `url(${detailMenu.image})`,
            }}
          ></div>
          <div style={{ display: "flex", flexDirection: "column" }}>
            <div style={DetailedMenuStyles.textMenu}>{detailMenu.name}</div>
            <div style={DetailedMenuStyles.textMenu}>{menuPrice}원</div>
          </div>
        </div>

        <div style={DetailedMenuStyles.line} />

        <div
          style={{
            position: "relative",
            width: "100%",
            paddingTop: "100%",
            backgroundColor: isEnded && "rgba(0,0,0,0.7)",
            borderRadius: 16,
          }}
        >
          {detailMenu.sign_language_urls && (
            <video
              ref={videoRef}
              src={videoList[currentIndex]}
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
              onEnded={handleVideoEnd}
            />
          )}
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

        <div style={DetailedMenuStyles.line} />

        {detailMenu.options?.[0]?.type === "temperature" && (
          <div style={DetailedMenuStyles.containerRow}>
            <ButtonTemperature
              icon={<IconCold />}
              text="차갑게"
              isSelected={selectedTemp === "차갑게"}
              onClick={() => setSelectedTemp("차갑게")}
            />
            <ButtonTemperature
              icon={<IconHot />}
              text="뜨겁게"
              isSelected={selectedTemp === "뜨겁게"}
              onClick={() => setSelectedTemp("뜨겁게")}
            />
          </div>
        )}

        {detailMenu.options?.[1]?.type === "size" && (
          <div style={DetailedMenuStyles.containerRow}>
            <ButtonSize
              size="S"
              icon={<IconSize width={32} height={34.91} />}
              text="적게"
              isSelected={selectedSize === "적게"}
              onClick={() => setSelectedSize("적게")}
            />
            <ButtonSize
              size="M"
              icon={<IconSize width={36} height={39.27} />}
              text="보통"
              isSelected={selectedSize === "보통"}
              onClick={() => setSelectedSize("보통")}
            />
            <ButtonSize
              size="L"
              icon={<IconSize width={40} height={43.63} />}
              text="많이"
              isSelected={selectedSize === "많이"}
              onClick={() => setSelectedSize("많이")}
            />
          </div>
        )}

        <Button
          icon={<IconShoppingCart />}
          text="장바구니 담기"
          onClick={handleAddCart}
        />
      </div>
    </>
  );
};

export default DetailedMenuPage;
