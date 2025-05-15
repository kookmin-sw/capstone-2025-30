//
//  Generated code. Do not modify.
//  source: inquiry.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use inquiryRequestDescriptor instead')
const InquiryRequest$json = {
  '1': 'InquiryRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'frame_data', '3': 2, '4': 3, '5': 2, '10': 'frameData'},
    {'1': 'inquiry_type', '3': 3, '4': 1, '5': 9, '10': 'inquiryType'},
    {'1': 'num', '3': 4, '4': 1, '5': 5, '10': 'num'},
  ],
};

/// Descriptor for `InquiryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inquiryRequestDescriptor = $convert.base64Decode(
    'Cg5JbnF1aXJ5UmVxdWVzdBIdCgpzdG9yZV9jb2RlGAEgASgJUglzdG9yZUNvZGUSHQoKZnJhbW'
    'VfZGF0YRgCIAMoAlIJZnJhbWVEYXRhEiEKDGlucXVpcnlfdHlwZRgDIAEoCVILaW5xdWlyeVR5'
    'cGUSEAoDbnVtGAQgASgFUgNudW0=');

@$core.Deprecated('Use inquiryResponseDescriptor instead')
const InquiryResponse$json = {
  '1': 'InquiryResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `InquiryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inquiryResponseDescriptor = $convert.base64Decode(
    'Cg9JbnF1aXJ5UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIiCgVlcnJvchgCIA'
    'EoDjIHLkVFcnJvckgAUgVlcnJvcogBAUIICgZfZXJyb3I=');

@$core.Deprecated('Use fastInquiryRespIsNoRequestDescriptor instead')
const FastInquiryRespIsNoRequest$json = {
  '1': 'FastInquiryRespIsNoRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'num', '3': 3, '4': 1, '5': 5, '10': 'num'},
  ],
};

/// Descriptor for `FastInquiryRespIsNoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fastInquiryRespIsNoRequestDescriptor = $convert.base64Decode(
    'ChpGYXN0SW5xdWlyeVJlc3BJc05vUmVxdWVzdBIdCgpzdG9yZV9jb2RlGAEgASgJUglzdG9yZU'
    'NvZGUSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhAKA251bRgDIAEoBVIDbnVt');

@$core.Deprecated('Use fastInquiryRespIsNoResponseDescriptor instead')
const FastInquiryRespIsNoResponse$json = {
  '1': 'FastInquiryRespIsNoResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `FastInquiryRespIsNoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fastInquiryRespIsNoResponseDescriptor = $convert.base64Decode(
    'ChtGYXN0SW5xdWlyeVJlc3BJc05vUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcx'
    'IiCgVlcnJvchgCIAEoDjIHLkVFcnJvckgAUgVlcnJvcogBAUIICgZfZXJyb3I=');

