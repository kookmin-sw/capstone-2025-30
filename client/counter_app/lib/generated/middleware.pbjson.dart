//
//  Generated code. Do not modify.
//  source: middleware.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use frameToMarkingDataRequestDescriptor instead')
const FrameToMarkingDataRequest$json = {
  '1': 'FrameToMarkingDataRequest',
  '2': [
    {'1': 'frame', '3': 1, '4': 3, '5': 12, '10': 'frame'},
    {'1': 'store_id', '3': 2, '4': 1, '5': 9, '10': 'storeId'},
    {'1': 'inquiry_type', '3': 3, '4': 1, '5': 9, '10': 'inquiryType'},
    {'1': 'num', '3': 4, '4': 1, '5': 5, '10': 'num'},
  ],
};

/// Descriptor for `FrameToMarkingDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List frameToMarkingDataRequestDescriptor = $convert.base64Decode(
    'ChlGcmFtZVRvTWFya2luZ0RhdGFSZXF1ZXN0EhQKBWZyYW1lGAEgAygMUgVmcmFtZRIZCghzdG'
    '9yZV9pZBgCIAEoCVIHc3RvcmVJZBIhCgxpbnF1aXJ5X3R5cGUYAyABKAlSC2lucXVpcnlUeXBl'
    'EhAKA251bRgEIAEoBVIDbnVt');

@$core.Deprecated('Use frameToMarkingDataResposneDescriptor instead')
const FrameToMarkingDataResposne$json = {
  '1': 'FrameToMarkingDataResposne',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `FrameToMarkingDataResposne`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List frameToMarkingDataResposneDescriptor = $convert.base64Decode(
    'ChpGcmFtZVRvTWFya2luZ0RhdGFSZXNwb3NuZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEi'
    'IKBWVycm9yGAIgASgOMgcuRUVycm9ySABSBWVycm9yiAEBQggKBl9lcnJvcg==');

