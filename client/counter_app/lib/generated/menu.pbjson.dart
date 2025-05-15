//
//  Generated code. Do not modify.
//  source: menu.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use optionDescriptor instead')
const Option$json = {
  '1': 'Option',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'choices', '3': 2, '4': 3, '5': 9, '10': 'choices'},
    {'1': 'option_price', '3': 3, '4': 3, '5': 5, '10': 'optionPrice'},
  ],
};

/// Descriptor for `Option`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List optionDescriptor = $convert.base64Decode(
    'CgZPcHRpb24SEgoEdHlwZRgBIAEoCVIEdHlwZRIYCgdjaG9pY2VzGAIgAygJUgdjaG9pY2VzEi'
    'EKDG9wdGlvbl9wcmljZRgDIAMoBVILb3B0aW9uUHJpY2U=');

@$core.Deprecated('Use viewMenuDescriptor instead')
const ViewMenu$json = {
  '1': 'ViewMenu',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'menu_price', '3': 3, '4': 1, '5': 5, '10': 'menuPrice'},
    {'1': 'image', '3': 4, '4': 1, '5': 9, '10': 'image'},
  ],
};

/// Descriptor for `ViewMenu`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewMenuDescriptor = $convert.base64Decode(
    'CghWaWV3TWVudRIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcnkSEgoEbmFtZRgCIAEoCVIEbm'
    'FtZRIdCgptZW51X3ByaWNlGAMgASgFUgltZW51UHJpY2USFAoFaW1hZ2UYBCABKAlSBWltYWdl');

@$core.Deprecated('Use viewMenuDetailDescriptor instead')
const ViewMenuDetail$json = {
  '1': 'ViewMenuDetail',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'menu_price', '3': 3, '4': 1, '5': 5, '10': 'menuPrice'},
    {'1': 'image', '3': 4, '4': 1, '5': 9, '10': 'image'},
    {'1': 'sign_language_urls', '3': 5, '4': 3, '5': 9, '10': 'signLanguageUrls'},
    {'1': 'options', '3': 6, '4': 3, '5': 11, '6': '.Option', '10': 'options'},
  ],
};

/// Descriptor for `ViewMenuDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewMenuDetailDescriptor = $convert.base64Decode(
    'Cg5WaWV3TWVudURldGFpbBIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcnkSEgoEbmFtZRgCIA'
    'EoCVIEbmFtZRIdCgptZW51X3ByaWNlGAMgASgFUgltZW51UHJpY2USFAoFaW1hZ2UYBCABKAlS'
    'BWltYWdlEiwKEnNpZ25fbGFuZ3VhZ2VfdXJscxgFIAMoCVIQc2lnbkxhbmd1YWdlVXJscxIhCg'
    'dvcHRpb25zGAYgAygLMgcuT3B0aW9uUgdvcHRpb25z');

@$core.Deprecated('Use createMenuRequestDescriptor instead')
const CreateMenuRequest$json = {
  '1': 'CreateMenuRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'menu_price', '3': 4, '4': 1, '5': 5, '10': 'menuPrice'},
    {'1': 'options', '3': 5, '4': 3, '5': 11, '6': '.Option', '10': 'options'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'sign_language_description', '3': 7, '4': 1, '5': 9, '10': 'signLanguageDescription'},
    {'1': 'sign_language_urls', '3': 8, '4': 3, '5': 9, '10': 'signLanguageUrls'},
    {'1': 'image', '3': 9, '4': 1, '5': 9, '10': 'image'},
  ],
};

/// Descriptor for `CreateMenuRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMenuRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVNZW51UmVxdWVzdBIdCgpzdG9yZV9jb2RlGAEgASgJUglzdG9yZUNvZGUSGgoIY2'
    'F0ZWdvcnkYAiABKAlSCGNhdGVnb3J5EhIKBG5hbWUYAyABKAlSBG5hbWUSHQoKbWVudV9wcmlj'
    'ZRgEIAEoBVIJbWVudVByaWNlEiEKB29wdGlvbnMYBSADKAsyBy5PcHRpb25SB29wdGlvbnMSIA'
    'oLZGVzY3JpcHRpb24YBiABKAlSC2Rlc2NyaXB0aW9uEjoKGXNpZ25fbGFuZ3VhZ2VfZGVzY3Jp'
    'cHRpb24YByABKAlSF3NpZ25MYW5ndWFnZURlc2NyaXB0aW9uEiwKEnNpZ25fbGFuZ3VhZ2VfdX'
    'JscxgIIAMoCVIQc2lnbkxhbmd1YWdlVXJscxIUCgVpbWFnZRgJIAEoCVIFaW1hZ2U=');

@$core.Deprecated('Use getCategoryListRequestDescriptor instead')
const GetCategoryListRequest$json = {
  '1': 'GetCategoryListRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
  ],
};

/// Descriptor for `GetCategoryListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryListRequestDescriptor = $convert.base64Decode(
    'ChZHZXRDYXRlZ29yeUxpc3RSZXF1ZXN0Eh0KCnN0b3JlX2NvZGUYASABKAlSCXN0b3JlQ29kZQ'
    '==');

@$core.Deprecated('Use getMenuListRequestDescriptor instead')
const GetMenuListRequest$json = {
  '1': 'GetMenuListRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `GetMenuListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMenuListRequestDescriptor = $convert.base64Decode(
    'ChJHZXRNZW51TGlzdFJlcXVlc3QSHQoKc3RvcmVfY29kZRgBIAEoCVIJc3RvcmVDb2RlEhoKCG'
    'NhdGVnb3J5GAIgASgJUghjYXRlZ29yeQ==');

@$core.Deprecated('Use getMenuDetailRequestDescriptor instead')
const GetMenuDetailRequest$json = {
  '1': 'GetMenuDetailRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GetMenuDetailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMenuDetailRequestDescriptor = $convert.base64Decode(
    'ChRHZXRNZW51RGV0YWlsUmVxdWVzdBIdCgpzdG9yZV9jb2RlGAEgASgJUglzdG9yZUNvZGUSGg'
    'oIY2F0ZWdvcnkYAiABKAlSCGNhdGVnb3J5EhIKBG5hbWUYAyABKAlSBG5hbWU=');

@$core.Deprecated('Use createMenuResponseDescriptor instead')
const CreateMenuResponse$json = {
  '1': 'CreateMenuResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'menu', '3': 3, '4': 1, '5': 11, '6': '.ViewMenu', '10': 'menu'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `CreateMenuResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMenuResponseDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVNZW51UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIiCgVlcnJvch'
    'gCIAEoDjIHLkVFcnJvckgAUgVlcnJvcogBARIdCgRtZW51GAMgASgLMgkuVmlld01lbnVSBG1l'
    'bnVCCAoGX2Vycm9y');

@$core.Deprecated('Use getCategoryListResponseDescriptor instead')
const GetCategoryListResponse$json = {
  '1': 'GetCategoryListResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'categories', '3': 3, '4': 3, '5': 9, '10': 'categories'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `GetCategoryListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryListResponseDescriptor = $convert.base64Decode(
    'ChdHZXRDYXRlZ29yeUxpc3RSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiIKBW'
    'Vycm9yGAIgASgOMgcuRUVycm9ySABSBWVycm9yiAEBEh4KCmNhdGVnb3JpZXMYAyADKAlSCmNh'
    'dGVnb3JpZXNCCAoGX2Vycm9y');

@$core.Deprecated('Use getMenuListResponseDescriptor instead')
const GetMenuListResponse$json = {
  '1': 'GetMenuListResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'menus', '3': 3, '4': 3, '5': 11, '6': '.ViewMenu', '10': 'menus'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `GetMenuListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMenuListResponseDescriptor = $convert.base64Decode(
    'ChNHZXRNZW51TGlzdFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIgoFZXJyb3'
    'IYAiABKA4yBy5FRXJyb3JIAFIFZXJyb3KIAQESHwoFbWVudXMYAyADKAsyCS5WaWV3TWVudVIF'
    'bWVudXNCCAoGX2Vycm9y');

@$core.Deprecated('Use getMenuDetailResponseDescriptor instead')
const GetMenuDetailResponse$json = {
  '1': 'GetMenuDetailResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'menu', '3': 3, '4': 1, '5': 11, '6': '.ViewMenuDetail', '10': 'menu'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `GetMenuDetailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMenuDetailResponseDescriptor = $convert.base64Decode(
    'ChVHZXRNZW51RGV0YWlsUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIiCgVlcn'
    'JvchgCIAEoDjIHLkVFcnJvckgAUgVlcnJvcogBARIjCgRtZW51GAMgASgLMg8uVmlld01lbnVE'
    'ZXRhaWxSBG1lbnVCCAoGX2Vycm9y');

