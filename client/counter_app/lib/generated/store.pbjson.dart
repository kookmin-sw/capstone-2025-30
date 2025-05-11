//
//  Generated code. Do not modify.
//  source: store.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use viewStoreDescriptor instead')
const ViewStore$json = {
  '1': 'ViewStore',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'location', '3': 3, '4': 1, '5': 9, '10': 'location'},
  ],
};

/// Descriptor for `ViewStore`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewStoreDescriptor = $convert.base64Decode(
    'CglWaWV3U3RvcmUSHQoKc3RvcmVfY29kZRgBIAEoCVIJc3RvcmVDb2RlEhIKBG5hbWUYAiABKA'
    'lSBG5hbWUSGgoIbG9jYXRpb24YAyABKAlSCGxvY2F0aW9u');

@$core.Deprecated('Use createStoreRequestDescriptor instead')
const CreateStoreRequest$json = {
  '1': 'CreateStoreRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'location', '3': 2, '4': 1, '5': 9, '10': 'location'},
  ],
};

/// Descriptor for `CreateStoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createStoreRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVTdG9yZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIaCghsb2NhdGlvbhgCIA'
    'EoCVIIbG9jYXRpb24=');

@$core.Deprecated('Use updateStoreRequestDescriptor instead')
const UpdateStoreRequest$json = {
  '1': 'UpdateStoreRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'location', '3': 3, '4': 1, '5': 9, '10': 'location'},
  ],
};

/// Descriptor for `UpdateStoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateStoreRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVTdG9yZVJlcXVlc3QSHQoKc3RvcmVfY29kZRgBIAEoCVIJc3RvcmVDb2RlEhIKBG'
    '5hbWUYAiABKAlSBG5hbWUSGgoIbG9jYXRpb24YAyABKAlSCGxvY2F0aW9u');

@$core.Deprecated('Use getStoreRequestDescriptor instead')
const GetStoreRequest$json = {
  '1': 'GetStoreRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
  ],
};

/// Descriptor for `GetStoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStoreRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRTdG9yZVJlcXVlc3QSHQoKc3RvcmVfY29kZRgBIAEoCVIJc3RvcmVDb2Rl');

@$core.Deprecated('Use deleteStoreRequestDescriptor instead')
const DeleteStoreRequest$json = {
  '1': 'DeleteStoreRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
  ],
};

/// Descriptor for `DeleteStoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteStoreRequestDescriptor = $convert.base64Decode(
    'ChJEZWxldGVTdG9yZVJlcXVlc3QSHQoKc3RvcmVfY29kZRgBIAEoCVIJc3RvcmVDb2Rl');

@$core.Deprecated('Use createStoreResponseDescriptor instead')
const CreateStoreResponse$json = {
  '1': 'CreateStoreResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'store', '3': 3, '4': 1, '5': 11, '6': '.ViewStore', '10': 'store'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `CreateStoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createStoreResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVTdG9yZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIgoFZXJyb3'
    'IYAiABKA4yBy5FRXJyb3JIAFIFZXJyb3KIAQESIAoFc3RvcmUYAyABKAsyCi5WaWV3U3RvcmVS'
    'BXN0b3JlQggKBl9lcnJvcg==');

@$core.Deprecated('Use getStoreListResponseDescriptor instead')
const GetStoreListResponse$json = {
  '1': 'GetStoreListResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'stores', '3': 3, '4': 3, '5': 11, '6': '.ViewStore', '10': 'stores'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `GetStoreListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStoreListResponseDescriptor = $convert.base64Decode(
    'ChRHZXRTdG9yZUxpc3RSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiIKBWVycm'
    '9yGAIgASgOMgcuRUVycm9ySABSBWVycm9yiAEBEiIKBnN0b3JlcxgDIAMoCzIKLlZpZXdTdG9y'
    'ZVIGc3RvcmVzQggKBl9lcnJvcg==');

@$core.Deprecated('Use getStoreResponseDescriptor instead')
const GetStoreResponse$json = {
  '1': 'GetStoreResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'store', '3': 3, '4': 1, '5': 11, '6': '.ViewStore', '10': 'store'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `GetStoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStoreResponseDescriptor = $convert.base64Decode(
    'ChBHZXRTdG9yZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIgoFZXJyb3IYAi'
    'ABKA4yBy5FRXJyb3JIAFIFZXJyb3KIAQESIAoFc3RvcmUYAyABKAsyCi5WaWV3U3RvcmVSBXN0'
    'b3JlQggKBl9lcnJvcg==');

@$core.Deprecated('Use updateStoreResponseDescriptor instead')
const UpdateStoreResponse$json = {
  '1': 'UpdateStoreResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'store', '3': 3, '4': 1, '5': 11, '6': '.ViewStore', '10': 'store'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `UpdateStoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateStoreResponseDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVTdG9yZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIgoFZXJyb3'
    'IYAiABKA4yBy5FRXJyb3JIAFIFZXJyb3KIAQESIAoFc3RvcmUYAyABKAsyCi5WaWV3U3RvcmVS'
    'BXN0b3JlQggKBl9lcnJvcg==');

@$core.Deprecated('Use deleteStoreResponseDescriptor instead')
const DeleteStoreResponse$json = {
  '1': 'DeleteStoreResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `DeleteStoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteStoreResponseDescriptor = $convert.base64Decode(
    'ChNEZWxldGVTdG9yZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIgoFZXJyb3'
    'IYAiABKA4yBy5FRXJyb3JIAFIFZXJyb3KIAQFCCAoGX2Vycm9y');

