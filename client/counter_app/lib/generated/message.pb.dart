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

import 'error.pbenum.dart' as $9;
import 'google/protobuf/timestamp.pb.dart' as $10;
import 'message.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'message.pbenum.dart';

class GetMessagesRequest extends $pb.GeneratedMessage {
  factory GetMessagesRequest({
    $core.String? storeCode,
    $core.String? notificationTitle,
    $core.int? number,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (notificationTitle != null) {
      $result.notificationTitle = notificationTitle;
    }
    if (number != null) {
      $result.number = number;
    }
    return $result;
  }
  GetMessagesRequest._() : super();
  factory GetMessagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMessagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMessagesRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..aOS(2, _omitFieldNames ? '' : 'notificationTitle')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'number', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMessagesRequest clone() => GetMessagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMessagesRequest copyWith(void Function(GetMessagesRequest) updates) => super.copyWith((message) => updates(message as GetMessagesRequest)) as GetMessagesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest create() => GetMessagesRequest._();
  GetMessagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMessagesRequest> createRepeated() => $pb.PbList<GetMessagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMessagesRequest>(create);
  static GetMessagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get notificationTitle => $_getSZ(1);
  @$pb.TagNumber(2)
  set notificationTitle($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNotificationTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearNotificationTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get number => $_getIZ(2);
  @$pb.TagNumber(3)
  set number($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumber() => $_clearField(3);
}

class GetMessagesResponse extends $pb.GeneratedMessage {
  factory GetMessagesResponse({
    $core.bool? success,
    $core.String? title,
    $core.int? number,
    $core.Iterable<Message>? messages,
    $9.EError? error,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (title != null) {
      $result.title = title;
    }
    if (number != null) {
      $result.number = number;
    }
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  GetMessagesResponse._() : super();
  factory GetMessagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMessagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMessagesResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'number', $pb.PbFieldType.O3)
    ..pc<Message>(4, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: Message.create)
    ..e<$9.EError>(5, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMessagesResponse clone() => GetMessagesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMessagesResponse copyWith(void Function(GetMessagesResponse) updates) => super.copyWith((message) => updates(message as GetMessagesResponse)) as GetMessagesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse create() => GetMessagesResponse._();
  GetMessagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMessagesResponse> createRepeated() => $pb.PbList<GetMessagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMessagesResponse>(create);
  static GetMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get number => $_getIZ(2);
  @$pb.TagNumber(3)
  set number($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<Message> get messages => $_getList(3);

  @$pb.TagNumber(5)
  $9.EError get error => $_getN(4);
  @$pb.TagNumber(5)
  set error($9.EError v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasError() => $_has(4);
  @$pb.TagNumber(5)
  void clearError() => $_clearField(5);
}

class Message extends $pb.GeneratedMessage {
  factory Message({
    $core.String? message,
    $core.bool? isOwner,
    $10.Timestamp? createdAt,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    if (isOwner != null) {
      $result.isOwner = isOwner;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  Message._() : super();
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Message', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOB(2, _omitFieldNames ? '' : 'isOwner')
    ..aOM<$10.Timestamp>(3, _omitFieldNames ? '' : 'createdAt', subBuilder: $10.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isOwner => $_getBF(1);
  @$pb.TagNumber(2)
  set isOwner($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsOwner() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsOwner() => $_clearField(2);

  @$pb.TagNumber(3)
  $10.Timestamp get createdAt => $_getN(2);
  @$pb.TagNumber(3)
  set createdAt($10.Timestamp v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $10.Timestamp ensureCreatedAt() => $_ensure(2);
}

class GetChatRoomListRequest extends $pb.GeneratedMessage {
  factory GetChatRoomListRequest({
    $core.String? storeCode,
    ChatRoomStatus? chatRoomStatus,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (chatRoomStatus != null) {
      $result.chatRoomStatus = chatRoomStatus;
    }
    return $result;
  }
  GetChatRoomListRequest._() : super();
  factory GetChatRoomListRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetChatRoomListRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetChatRoomListRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..e<ChatRoomStatus>(2, _omitFieldNames ? '' : 'chatRoomStatus', $pb.PbFieldType.OE, defaultOrMaker: ChatRoomStatus.CHATROOM_STATUS_COMPLETE, valueOf: ChatRoomStatus.valueOf, enumValues: ChatRoomStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetChatRoomListRequest clone() => GetChatRoomListRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetChatRoomListRequest copyWith(void Function(GetChatRoomListRequest) updates) => super.copyWith((message) => updates(message as GetChatRoomListRequest)) as GetChatRoomListRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChatRoomListRequest create() => GetChatRoomListRequest._();
  GetChatRoomListRequest createEmptyInstance() => create();
  static $pb.PbList<GetChatRoomListRequest> createRepeated() => $pb.PbList<GetChatRoomListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetChatRoomListRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChatRoomListRequest>(create);
  static GetChatRoomListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  ChatRoomStatus get chatRoomStatus => $_getN(1);
  @$pb.TagNumber(2)
  set chatRoomStatus(ChatRoomStatus v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasChatRoomStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearChatRoomStatus() => $_clearField(2);
}

class GetChatRoomListResponse extends $pb.GeneratedMessage {
  factory GetChatRoomListResponse({
    $core.bool? success,
    $9.EError? error,
    $core.Iterable<ChatRoomInfo>? chatRoomInfos,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (chatRoomInfos != null) {
      $result.chatRoomInfos.addAll(chatRoomInfos);
    }
    return $result;
  }
  GetChatRoomListResponse._() : super();
  factory GetChatRoomListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetChatRoomListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetChatRoomListResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..pc<ChatRoomInfo>(3, _omitFieldNames ? '' : 'chatRoomInfos', $pb.PbFieldType.PM, subBuilder: ChatRoomInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetChatRoomListResponse clone() => GetChatRoomListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetChatRoomListResponse copyWith(void Function(GetChatRoomListResponse) updates) => super.copyWith((message) => updates(message as GetChatRoomListResponse)) as GetChatRoomListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChatRoomListResponse create() => GetChatRoomListResponse._();
  GetChatRoomListResponse createEmptyInstance() => create();
  static $pb.PbList<GetChatRoomListResponse> createRepeated() => $pb.PbList<GetChatRoomListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetChatRoomListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChatRoomListResponse>(create);
  static GetChatRoomListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $9.EError get error => $_getN(1);
  @$pb.TagNumber(2)
  set error($9.EError v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<ChatRoomInfo> get chatRoomInfos => $_getList(2);
}

class ChatRoomInfo extends $pb.GeneratedMessage {
  factory ChatRoomInfo({
    $core.String? notificationTitle,
    $core.int? number,
  }) {
    final $result = create();
    if (notificationTitle != null) {
      $result.notificationTitle = notificationTitle;
    }
    if (number != null) {
      $result.number = number;
    }
    return $result;
  }
  ChatRoomInfo._() : super();
  factory ChatRoomInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatRoomInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatRoomInfo', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'notificationTitle')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'number', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatRoomInfo clone() => ChatRoomInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatRoomInfo copyWith(void Function(ChatRoomInfo) updates) => super.copyWith((message) => updates(message as ChatRoomInfo)) as ChatRoomInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatRoomInfo create() => ChatRoomInfo._();
  ChatRoomInfo createEmptyInstance() => create();
  static $pb.PbList<ChatRoomInfo> createRepeated() => $pb.PbList<ChatRoomInfo>();
  @$core.pragma('dart2js:noInline')
  static ChatRoomInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatRoomInfo>(create);
  static ChatRoomInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get notificationTitle => $_getSZ(0);
  @$pb.TagNumber(1)
  set notificationTitle($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNotificationTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotificationTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get number => $_getIZ(1);
  @$pb.TagNumber(2)
  set number($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => $_clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
