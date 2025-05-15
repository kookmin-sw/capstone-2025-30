//
//  Generated code. Do not modify.
//  source: all_predict_sign.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use frameSequenceInputDescriptor instead')
const FrameSequenceInput$json = {
  '1': 'FrameSequenceInput',
  '2': [
    {'1': 'frames', '3': 1, '4': 3, '5': 2, '10': 'frames'},
    {'1': 'store_id', '3': 2, '4': 1, '5': 9, '10': 'storeId'},
    {'1': 'fps', '3': 3, '4': 1, '5': 5, '10': 'fps'},
    {'1': 'video_length', '3': 4, '4': 1, '5': 5, '10': 'videoLength'},
  ],
};

/// Descriptor for `FrameSequenceInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List frameSequenceInputDescriptor = $convert.base64Decode(
    'ChJGcmFtZVNlcXVlbmNlSW5wdXQSFgoGZnJhbWVzGAEgAygCUgZmcmFtZXMSGQoIc3RvcmVfaW'
    'QYAiABKAlSB3N0b3JlSWQSEAoDZnBzGAMgASgFUgNmcHMSIQoMdmlkZW9fbGVuZ3RoGAQgASgF'
    'Ugt2aWRlb0xlbmd0aA==');

@$core.Deprecated('Use predictResultDescriptor instead')
const PredictResult$json = {
  '1': 'PredictResult',
  '2': [
    {'1': 'store_id', '3': 1, '4': 1, '5': 9, '10': 'storeId'},
    {'1': 'predicted_sentence', '3': 2, '4': 1, '5': 9, '10': 'predictedSentence'},
    {'1': 'confidence', '3': 3, '4': 1, '5': 2, '10': 'confidence'},
  ],
};

/// Descriptor for `PredictResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List predictResultDescriptor = $convert.base64Decode(
    'Cg1QcmVkaWN0UmVzdWx0EhkKCHN0b3JlX2lkGAEgASgJUgdzdG9yZUlkEi0KEnByZWRpY3RlZF'
    '9zZW50ZW5jZRgCIAEoCVIRcHJlZGljdGVkU2VudGVuY2USHgoKY29uZmlkZW5jZRgDIAEoAlIK'
    'Y29uZmlkZW5jZQ==');

@$core.Deprecated('Use koreanInputDescriptor instead')
const KoreanInput$json = {
  '1': 'KoreanInput',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'store_id', '3': 2, '4': 1, '5': 9, '10': 'storeId'},
  ],
};

/// Descriptor for `KoreanInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List koreanInputDescriptor = $convert.base64Decode(
    'CgtLb3JlYW5JbnB1dBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEhkKCHN0b3JlX2lkGAIgAS'
    'gJUgdzdG9yZUlk');

@$core.Deprecated('Use signUrlResultDescriptor instead')
const SignUrlResult$json = {
  '1': 'SignUrlResult',
  '2': [
    {'1': 'store_id', '3': 1, '4': 1, '5': 9, '10': 'storeId'},
    {'1': 'urls', '3': 2, '4': 3, '5': 9, '10': 'urls'},
  ],
};

/// Descriptor for `SignUrlResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUrlResultDescriptor = $convert.base64Decode(
    'Cg1TaWduVXJsUmVzdWx0EhkKCHN0b3JlX2lkGAEgASgJUgdzdG9yZUlkEhIKBHVybHMYAiADKA'
    'lSBHVybHM=');

