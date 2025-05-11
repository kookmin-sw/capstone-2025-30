//
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ChatRoomStatus extends $pb.ProtobufEnum {
  static const ChatRoomStatus CHATROOM_STATUS_COMPLETE = ChatRoomStatus._(0, _omitEnumNames ? '' : 'CHATROOM_STATUS_COMPLETE');
  static const ChatRoomStatus CHATROOM_STATUS_BEFORE = ChatRoomStatus._(1, _omitEnumNames ? '' : 'CHATROOM_STATUS_BEFORE');

  static const $core.List<ChatRoomStatus> values = <ChatRoomStatus> [
    CHATROOM_STATUS_COMPLETE,
    CHATROOM_STATUS_BEFORE,
  ];

  static final $core.Map<$core.int, ChatRoomStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChatRoomStatus? valueOf($core.int value) => _byValue[value];

  const ChatRoomStatus._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
