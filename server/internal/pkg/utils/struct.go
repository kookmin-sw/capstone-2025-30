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
