//
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use chatRoomStatusDescriptor instead')
const ChatRoomStatus$json = {
  '1': 'ChatRoomStatus',
  '2': [
    {'1': 'CHATROOM_STATUS_COMPLETE', '2': 0},
    {'1': 'CHATROOM_STATUS_BEFORE', '2': 1},
  ],
};

/// Descriptor for `ChatRoomStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List chatRoomStatusDescriptor = $convert.base64Decode(
    'Cg5DaGF0Um9vbVN0YXR1cxIcChhDSEFUUk9PTV9TVEFUVVNfQ09NUExFVEUQABIaChZDSEFUUk'
    '9PTV9TVEFUVVNfQkVGT1JFEAE=');

@$core.Deprecated('Use getMessagesRequestDescriptor instead')
const GetMessagesRequest$json = {
  '1': 'GetMessagesRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'notification_title', '3': 2, '4': 1, '5': 9, '10': 'notificationTitle'},
    {'1': 'number', '3': 3, '4': 1, '5': 5, '10': 'number'},
  ],
};

/// Descriptor for `GetMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRNZXNzYWdlc1JlcXVlc3QSHQoKc3RvcmVfY29kZRgBIAEoCVIJc3RvcmVDb2RlEi0KEm'
    '5vdGlmaWNhdGlvbl90aXRsZRgCIAEoCVIRbm90aWZpY2F0aW9uVGl0bGUSFgoGbnVtYmVyGAMg'
    'ASgFUgZudW1iZXI=');

@$core.Deprecated('Use getMessagesResponseDescriptor instead')
const GetMessagesResponse$json = {
  '1': 'GetMessagesResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'title', '17': true},
    {'1': 'number', '3': 3, '4': 1, '5': 5, '9': 1, '10': 'number', '17': true},
    {'1': 'messages', '3': 4, '4': 3, '5': 11, '6': '.Message', '10': 'messages'},
    {'1': 'error', '3': 5, '4': 1, '5': 14, '6': '.EError', '9': 2, '10': 'error', '17': true},
  ],
  '8': [
    {'1': '_title'},
    {'1': '_number'},
    {'1': '_error'},
  ],
};

/// Descriptor for `GetMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesResponseDescriptor = $convert.base64Decode(
    'ChNHZXRNZXNzYWdlc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGQoFdGl0bG'
    'UYAiABKAlIAFIFdGl0bGWIAQESGwoGbnVtYmVyGAMgASgFSAFSBm51bWJlcogBARIkCghtZXNz'
    'YWdlcxgEIAMoCzIILk1lc3NhZ2VSCG1lc3NhZ2VzEiIKBWVycm9yGAUgASgOMgcuRUVycm9ySA'
    'JSBWVycm9yiAEBQggKBl90aXRsZUIJCgdfbnVtYmVyQggKBl9lcnJvcg==');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_owner', '3': 2, '4': 1, '5': 8, '10': 'isOwner'},
    {'1': 'created_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USGQoIaXNfb3duZXIYAiABKAhSB2'
    'lzT3duZXISOQoKY3JlYXRlZF9hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBS'
    'CWNyZWF0ZWRBdA==');

@$core.Deprecated('Use getChatRoomListRequestDescriptor instead')
const GetChatRoomListRequest$json = {
  '1': 'GetChatRoomListRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'chat_room_status', '3': 2, '4': 1, '5': 14, '6': '.ChatRoomStatus', '10': 'chatRoomStatus'},
  ],
};

/// Descriptor for `GetChatRoomListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChatRoomListRequestDescriptor = $convert.base64Decode(
    'ChZHZXRDaGF0Um9vbUxpc3RSZXF1ZXN0Eh0KCnN0b3JlX2NvZGUYASABKAlSCXN0b3JlQ29kZR'
    'I5ChBjaGF0X3Jvb21fc3RhdHVzGAIgASgOMg8uQ2hhdFJvb21TdGF0dXNSDmNoYXRSb29tU3Rh'
    'dHVz');

@$core.Deprecated('Use getChatRoomListResponseDescriptor instead')
const GetChatRoomListResponse$json = {
  '1': 'GetChatRoomListResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'chat_room_infos', '3': 3, '4': 3, '5': 11, '6': '.ChatRoomInfo', '10': 'chatRoomInfos'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `GetChatRoomListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChatRoomListResponseDescriptor = $convert.base64Decode(
    'ChdHZXRDaGF0Um9vbUxpc3RSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiIKBW'
    'Vycm9yGAIgASgOMgcuRUVycm9ySABSBWVycm9yiAEBEjUKD2NoYXRfcm9vbV9pbmZvcxgDIAMo'
    'CzINLkNoYXRSb29tSW5mb1INY2hhdFJvb21JbmZvc0IICgZfZXJyb3I=');

@$core.Deprecated('Use chatRoomInfoDescriptor instead')
const ChatRoomInfo$json = {
  '1': 'ChatRoomInfo',
  '2': [
    {'1': 'notification_title', '3': 1, '4': 1, '5': 9, '10': 'notificationTitle'},
    {'1': 'number', '3': 2, '4': 1, '5': 5, '10': 'number'},
  ],
};

/// Descriptor for `ChatRoomInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatRoomInfoDescriptor = $convert.base64Decode(
    'CgxDaGF0Um9vbUluZm8SLQoSbm90aWZpY2F0aW9uX3RpdGxlGAEgASgJUhFub3RpZmljYXRpb2'
    '5UaXRsZRIWCgZudW1iZXIYAiABKAVSBm51bWJlcg==');

