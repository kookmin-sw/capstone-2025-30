//
//  Generated code. Do not modify.
//  source: error.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EError extends $pb.ProtobufEnum {
  static const EError EE_UNSPECIFIED = EError._(0, _omitEnumNames ? '' : 'EE_UNSPECIFIED');
  /// 공통
  static const EError EE_API_FAILED = EError._(10000, _omitEnumNames ? '' : 'EE_API_FAILED');
  static const EError EE_API_AUTH_FAILED = EError._(10001, _omitEnumNames ? '' : 'EE_API_AUTH_FAILED');
  static const EError EE_INVALID_ARGUMENT = EError._(10002, _omitEnumNames ? '' : 'EE_INVALID_ARGUMENT');
  static const EError EE_DB_OPERATION_FAILED = EError._(10003, _omitEnumNames ? '' : 'EE_DB_OPERATION_FAILED');
  /// store
  static const EError EE_STORE_ALREADY_EXISTS = EError._(20000, _omitEnumNames ? '' : 'EE_STORE_ALREADY_EXISTS');
  static const EError EE_STORE_NOT_FOUND = EError._(20001, _omitEnumNames ? '' : 'EE_STORE_NOT_FOUND');
  static const EError EE_STORE_UPDATE_NO_FIELDS = EError._(20002, _omitEnumNames ? '' : 'EE_STORE_UPDATE_NO_FIELDS');
  /// inquiry
  static const EError EE_INQUIRY_STREAM_FAILED = EError._(30000, _omitEnumNames ? '' : 'EE_INQUIRY_STREAM_FAILED');
  /// order
  static const EError EE_ORDER_AND_NOTIFICATION_AND_MESSAGE_DB_ADD_FAILED = EError._(40000, _omitEnumNames ? '' : 'EE_ORDER_AND_NOTIFICATION_AND_MESSAGE_DB_ADD_FAILED');
  static const EError EE_ORDER_NOT_FOUND = EError._(40001, _omitEnumNames ? '' : 'EE_ORDER_NOT_FOUND');
  /// menu
  static const EError EE_MENU_ALREADY_EXISTS = EError._(50000, _omitEnumNames ? '' : 'EE_MENU_ALREADY_EXISTS');
  static const EError EE_MENU_NOT_FOUND = EError._(50001, _omitEnumNames ? '' : 'EE_MENU_NOT_FOUND');
  static const EError EE_MENU_CATEGORY_NOT_FOUND = EError._(50002, _omitEnumNames ? '' : 'EE_MENU_CATEGORY_NOT_FOUND');
  /// message
  static const EError EE_NOTIFICATION_NOT_FOUND = EError._(60000, _omitEnumNames ? '' : 'EE_NOTIFICATION_NOT_FOUND');
  static const EError EE_MESSAGE_CREATE_FAILED = EError._(60001, _omitEnumNames ? '' : 'EE_MESSAGE_CREATE_FAILED');

  static const $core.List<EError> values = <EError> [
    EE_UNSPECIFIED,
    EE_API_FAILED,
    EE_API_AUTH_FAILED,
    EE_INVALID_ARGUMENT,
    EE_DB_OPERATION_FAILED,
    EE_STORE_ALREADY_EXISTS,
    EE_STORE_NOT_FOUND,
    EE_STORE_UPDATE_NO_FIELDS,
    EE_INQUIRY_STREAM_FAILED,
    EE_ORDER_AND_NOTIFICATION_AND_MESSAGE_DB_ADD_FAILED,
    EE_ORDER_NOT_FOUND,
    EE_MENU_ALREADY_EXISTS,
    EE_MENU_NOT_FOUND,
    EE_MENU_CATEGORY_NOT_FOUND,
    EE_NOTIFICATION_NOT_FOUND,
    EE_MESSAGE_CREATE_FAILED,
  ];

  static final $core.Map<$core.int, EError> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EError? valueOf($core.int value) => _byValue[value];

  const EError._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
