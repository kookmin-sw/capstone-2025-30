package utils

// WebSocket Message Types
const (
	WebSocketMessageTypeNotification = "notification"
	WebSocketMessageTypeOrder        = "orderMessage"
	WebSocketMessageTypeInquiry      = "inquiryMessage"
)

// WebSocket Notification Title Types
const (
	NotificationTitleOrder   = "order"
	NotificationTitleInquiry = "inquiry"
)

// WebSocket Message Status Types
const (
	MessageStatusDelivered = "delivered"
	MessageStatusRead      = "read"
	MessageStatusPending   = "pending"
)

// grpc StreamInquiries inquiryType
const (
	StreamDataTypeOrder   = "order"
	StreamDataTypeInquiry = "inquiry"
)

// WebSocket Client Types
const (
	WebSocketClientTypeCounterApp = "counter_app"
	WebSocketClientTypeManagerWeb = "manager_web"
)
