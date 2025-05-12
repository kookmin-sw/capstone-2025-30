//
//  Generated code. Do not modify.
//  source: test.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use testStructDescriptor instead')
const TestStruct$json = {
  '1': 'TestStruct',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'age', '3': 2, '4': 1, '5': 5, '10': 'age'},
    {'1': 'is_student', '3': 3, '4': 1, '5': 8, '10': 'isStudent'},
    {'1': 'friends', '3': 4, '4': 3, '5': 9, '10': 'friends'},
  ],
};

/// Descriptor for `TestStruct`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testStructDescriptor = $convert.base64Decode(
    'CgpUZXN0U3RydWN0EhIKBG5hbWUYASABKAlSBG5hbWUSEAoDYWdlGAIgASgFUgNhZ2USHQoKaX'
    'Nfc3R1ZGVudBgDIAEoCFIJaXNTdHVkZW50EhgKB2ZyaWVuZHMYBCADKAlSB2ZyaWVuZHM=');

@$core.Deprecated('Use addTestStructRequestDescriptor instead')
const AddTestStructRequest$json = {
  '1': 'AddTestStructRequest',
  '2': [
    {'1': 'test_struct', '3': 1, '4': 1, '5': 11, '6': '.TestStruct', '10': 'testStruct'},
  ],
};

/// Descriptor for `AddTestStructRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addTestStructRequestDescriptor = $convert.base64Decode(
    'ChRBZGRUZXN0U3RydWN0UmVxdWVzdBIsCgt0ZXN0X3N0cnVjdBgBIAEoCzILLlRlc3RTdHJ1Y3'
    'RSCnRlc3RTdHJ1Y3Q=');

@$core.Deprecated('Use addTestStructResponseDescriptor instead')
const AddTestStructResponse$json = {
  '1': 'AddTestStructResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `AddTestStructResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addTestStructResponseDescriptor = $convert.base64Decode(
    'ChVBZGRUZXN0U3RydWN0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

