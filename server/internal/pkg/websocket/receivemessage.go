package websocketHandler

import (
	"context"
	"strings"
	"time"

	pb "server/gen"
	mfastinquiry "server/internal/pkg/database/mongodb/fastinquiry"
	mmessage "server/internal/pkg/database/mongodb/message"
	mstore "server/internal/pkg/database/mongodb/store"
	dbstructure "server/internal/pkg/database/structure"
	"server/internal/pkg/utils"

	"github.com/sirupsen/logrus"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type WebSocketReceiveMessage struct {
	Title     string `json:"title"`
	Number    int    `json:"number"`
	Message   string `json:"message"`
	StoreCode string `json:"store_code"`
}

func ReceiveKoreanMessage(msg *WebSocketReceiveMessage) error {
	// 1. AI 서버에 한국어 메시지 전송하여 수화 URL 받기
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	currentTime := time.Now()

	// store_code를 store_id로 변환
	storeObjectID, err := mstore.ValidateStoreCodeAndGetObjectID(msg.StoreCode)
	if err != nil {
		logrus.Errorf("Store validation failed: %v", err)
		return err
	}

	// title & number notification coll 에 조회
	notificationTitle := ""
	if msg.Title == "orderMessage" {
		notificationTitle = "order"
	} else if msg.Title == "inquiryMessage" {
		notificationTitle = "inquiry"
	}

	_, err = mmessage.GetNotificationMessage(&storeObjectID, notificationTitle, msg.Number)
	if err != nil {
		logrus.Errorf("Failed to get notification: %v", err)
		return err
	}

	// 메시지에 "문의사항" 포함 여부 확인
	if strings.Contains(msg.Message, "문의사항") {
		// 문의사항 메시지 저장
		mMessage := dbstructure.MMessage{
			ID:        primitive.NewObjectID(),
			StoreId:   storeObjectID,
			Title:     msg.Title,
			Number:    int32(msg.Number),
			CreatedAt: currentTime,
			Message:   msg.Message,
			IsOwner:   true,
		}

		err = mmessage.CreateMMessage(&mMessage)
		if err != nil {
			logrus.Errorf("Failed to save message: %v", err)
			return err
		}

		notificationMessage := NotificationData{
			Title: notificationTitle,
			Num:   msg.Number,
		}

		message := WebSocketMessage{
			Type: "signMessage",
			Data: notificationMessage,
		}

		// 웹소켓으로 메시지 전송
		go func() {
			maxRetries := 3
			backoff := time.Second

			for attempt := 1; attempt <= maxRetries; attempt++ {
				if err := SendMessageToClient(msg.StoreCode, message, utils.WebSocketClientTypeCounterApp); err != nil {
					logrus.Warnf("Websocket send attempt %d failed: %v", attempt, err)

					if attempt == maxRetries {
						logrus.Errorf("Failed to send websocket notification after %d attempts: %v", maxRetries, err)
						return
					}

					time.Sleep(backoff)
					backoff *= 2
				} else {
					return
				}
			}
		}()

		logrus.Infof("Message saved and sign URLs sent successfully: %s (Order #%d)", msg.Title, msg.Number)
		return nil
	}

	if strings.Contains(msg.Message, "네") ||
		strings.Contains(msg.Message, "아니오") ||
		strings.Contains(msg.Message, "잠시만 기다려주세요") ||
		strings.Contains(msg.Message, "결제해드릴게요") {

		mMessage := dbstructure.MMessage{
			ID:        primitive.NewObjectID(),
			StoreId:   storeObjectID,
			Title:     msg.Title,
			Number:    int32(msg.Number),
			CreatedAt: currentTime,
			Message:   msg.Message,
			IsOwner:   true,
		}

		err = mmessage.CreateMMessage(&mMessage)
		if err != nil {
			logrus.Errorf("Failed to save message: %v", err)
			return err
		}

		fastInquiryData, err := mfastinquiry.GetFastInquiry(msg.Message)
		if err != nil {
			logrus.Errorf("Failed to get fast inquiry: %v", err)
			return err
		}

		message := WebSocketMessage{
			Type: "signMessage",
			Data: SignUrlData{
				SignUrls: fastInquiryData.URLs,
			},
		}

		// 웹소켓으로 메시지 전송
		go func() {
			maxRetries := 3
			backoff := time.Second

			for attempt := 1; attempt <= maxRetries; attempt++ {
				if err := SendMessageToClient(msg.StoreCode, message, utils.WebSocketClientTypeCounterApp); err != nil {
					logrus.Warnf("Websocket send attempt %d failed: %v", attempt, err)

					if attempt == maxRetries {
						logrus.Errorf("Failed to send websocket notification after %d attempts: %v", maxRetries, err)
						return
					}

					time.Sleep(backoff)
					backoff *= 2
				} else {
					return
				}
			}
		}()

		logrus.Infof("Message saved and sign URLs sent successfully: %s (Order #%d)", msg.Title, msg.Number)
		return nil
	}

	// AI 서버에 요청
	signUrlsResp, err := utils.AiClient.TranslateKoreanToSignUrls(ctx, &pb.KoreanInput{
		Message: msg.Message,
		StoreId: storeObjectID.Hex(),
	})
	if err != nil {
		logrus.Errorf("Failed to get sign URLs from AI server: %v", err)
		return err
	}

	// 2. 메시지 저장
	mMessage := dbstructure.MMessage{
		ID:        primitive.NewObjectID(),
		StoreId:   storeObjectID,
		Title:     msg.Title,
		Number:    int32(msg.Number),
		CreatedAt: currentTime,
		Message:   msg.Message,
		IsOwner:   true,
	}

	err = mmessage.CreateMMessage(&mMessage)
	if err != nil {
		logrus.Errorf("Failed to save message: %v", err)
		return err
	}

	// 3. 웹소켓으로 수화 URL 전송
	message := WebSocketMessage{
		Type: "signMessage",
		Data: SignUrlData{
			SignUrls: signUrlsResp.Urls,
		},
	}

	// 웹소켓으로 메시지 전송
	go func() {
		maxRetries := 3
		backoff := time.Second

		for attempt := 1; attempt <= maxRetries; attempt++ {
			if err := SendMessageToClient(msg.StoreCode, message, utils.WebSocketClientTypeCounterApp); err != nil {
				logrus.Warnf("Websocket send attempt %d failed: %v", attempt, err)

				if attempt == maxRetries {
					logrus.Errorf("Failed to send websocket notification after %d attempts: %v", maxRetries, err)
					return
				}

				time.Sleep(backoff)
				backoff *= 2
			} else {
				return
			}
		}
	}()

	logrus.Infof("Message saved and sign URLs sent successfully: %s (Order #%d)", msg.Title, msg.Number)
	return nil
}
