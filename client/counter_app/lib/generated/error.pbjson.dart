//
//  Generated code. Do not modify.
//  source: error.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use eErrorDescriptor instead')
const EError$json = {
  '1': 'EError',
  '2': [
    {'1': 'EE_UNSPECIFIED', '2': 0},
    {'1': 'EE_API_FAILED', '2': 10000},
    {'1': 'EE_API_AUTH_FAILED', '2': 10001},
    {'1': 'EE_INVALID_ARGUMENT', '2': 10002},
    {'1': 'EE_DB_OPERATION_FAILED', '2': 10003},
    {'1': 'EE_STORE_ALREADY_EXISTS', '2': 20000},
    {'1': 'EE_STORE_NOT_FOUND', '2': 20001},
    {'1': 'EE_STORE_UPDATE_NO_FIELDS', '2': 20002},
    {'1': 'EE_INQUIRY_STREAM_FAILED', '2': 30000},
    {'1': 'EE_ORDER_AND_NOTIFICATION_AND_MESSAGE_DB_ADD_FAILED', '2': 40000},
    {'1': 'EE_ORDER_NOT_FOUND', '2': 40001},
    {'1': 'EE_MENU_ALREADY_EXISTS', '2': 50000},
    {'1': 'EE_MENU_NOT_FOUND', '2': 50001},
    {'1': 'EE_MENU_CATEGORY_NOT_FOUND', '2': 50002},
    {'1': 'EE_NOTIFICATION_NOT_FOUND', '2': 60000},
    {'1': 'EE_MESSAGE_CREATE_FAILED', '2': 60001},
  ],
};

/// Descriptor for `EError`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List eErrorDescriptor = $convert.base64Decode(
    'CgZFRXJyb3ISEgoORUVfVU5TUEVDSUZJRUQQABISCg1FRV9BUElfRkFJTEVEEJBOEhcKEkVFX0'
    'FQSV9BVVRIX0ZBSUxFRBCRThIYChNFRV9JTlZBTElEX0FSR1VNRU5UEJJOEhsKFkVFX0RCX09Q'
    'RVJBVElPTl9GQUlMRUQQk04SHQoXRUVfU1RPUkVfQUxSRUFEWV9FWElTVFMQoJwBEhgKEkVFX1'
    'NUT1JFX05PVF9GT1VORBChnAESHwoZRUVfU1RPUkVfVVBEQVRFX05PX0ZJRUxEUxCinAESHgoY'
    'RUVfSU5RVUlSWV9TVFJFQU1fRkFJTEVEELDqARI5CjNFRV9PUkRFUl9BTkRfTk9USUZJQ0FUSU'
    '9OX0FORF9NRVNTQUdFX0RCX0FERF9GQUlMRUQQwLgCEhgKEkVFX09SREVSX05PVF9GT1VORBDB'
    'uAISHAoWRUVfTUVOVV9BTFJFQURZX0VYSVNUUxDQhgMSFwoRRUVfTUVOVV9OT1RfRk9VTkQQ0Y'
    'YDEiAKGkVFX01FTlVfQ0FURUdPUllfTk9UX0ZPVU5EENKGAxIfChlFRV9OT1RJRklDQVRJT05f'
    'Tk9UX0ZPVU5EEODUAxIeChhFRV9NRVNTQUdFX0NSRUFURV9GQUlMRUQQ4dQD');

