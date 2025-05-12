//
//  Generated code. Do not modify.
//  source: order.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use orderStatusDescriptor instead')
const OrderStatus$json = {
  '1': 'OrderStatus',
  '2': [
    {'1': 'ORDER_UNSPECIFIED', '2': 0},
    {'1': 'ORDER_PENDING', '2': 1},
    {'1': 'ORDER_PROCESSING', '2': 2},
    {'1': 'ORDER_DONE', '2': 3},
  ],
};

/// Descriptor for `OrderStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List orderStatusDescriptor = $convert.base64Decode(
    'CgtPcmRlclN0YXR1cxIVChFPUkRFUl9VTlNQRUNJRklFRBAAEhEKDU9SREVSX1BFTkRJTkcQAR'
    'IUChBPUkRFUl9QUk9DRVNTSU5HEAISDgoKT1JERVJfRE9ORRAD');

@$core.Deprecated('Use itemOptionsDescriptor instead')
const ItemOptions$json = {
  '1': 'ItemOptions',
  '2': [
    {'1': 'choices', '3': 1, '4': 3, '5': 11, '6': '.ItemOptions.ChoicesEntry', '10': 'choices'},
  ],
  '3': [ItemOptions_ChoicesEntry$json],
};

@$core.Deprecated('Use itemOptionsDescriptor instead')
const ItemOptions_ChoicesEntry$json = {
  '1': 'ChoicesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ItemOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List itemOptionsDescriptor = $convert.base64Decode(
    'CgtJdGVtT3B0aW9ucxIzCgdjaG9pY2VzGAEgAygLMhkuSXRlbU9wdGlvbnMuQ2hvaWNlc0VudH'
    'J5UgdjaG9pY2VzGjoKDENob2ljZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgC'
    'IAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use orderItemDescriptor instead')
const OrderItem$json = {
  '1': 'OrderItem',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'quantity', '3': 2, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'options', '3': 3, '4': 1, '5': 11, '6': '.ItemOptions', '10': 'options'},
    {'1': 'item_price', '3': 4, '4': 1, '5': 5, '10': 'itemPrice'},
    {'1': 'image', '3': 5, '4': 1, '5': 9, '10': 'image'},
  ],
};

/// Descriptor for `OrderItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderItemDescriptor = $convert.base64Decode(
    'CglPcmRlckl0ZW0SEgoEbmFtZRgBIAEoCVIEbmFtZRIaCghxdWFudGl0eRgCIAEoBVIIcXVhbn'
    'RpdHkSJgoHb3B0aW9ucxgDIAEoCzIMLkl0ZW1PcHRpb25zUgdvcHRpb25zEh0KCml0ZW1fcHJp'
    'Y2UYBCABKAVSCWl0ZW1QcmljZRIUCgVpbWFnZRgFIAEoCVIFaW1hZ2U=');

@$core.Deprecated('Use viewOrderSummaryDescriptor instead')
const ViewOrderSummary$json = {
  '1': 'ViewOrderSummary',
  '2': [
    {'1': 'order_number', '3': 1, '4': 1, '5': 5, '10': 'orderNumber'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.OrderStatus', '10': 'status'},
    {'1': 'created_at', '3': 3, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `ViewOrderSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewOrderSummaryDescriptor = $convert.base64Decode(
    'ChBWaWV3T3JkZXJTdW1tYXJ5EiEKDG9yZGVyX251bWJlchgBIAEoBVILb3JkZXJOdW1iZXISJA'
    'oGc3RhdHVzGAIgASgOMgwuT3JkZXJTdGF0dXNSBnN0YXR1cxIdCgpjcmVhdGVkX2F0GAMgASgJ'
    'UgljcmVhdGVkQXQ=');

@$core.Deprecated('Use orderDescriptor instead')
const Order$json = {
  '1': 'Order',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'order_number', '3': 2, '4': 1, '5': 5, '10': 'orderNumber'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.OrderStatus', '10': 'status'},
    {'1': 'items', '3': 4, '4': 3, '5': 11, '6': '.OrderItem', '10': 'items'},
  ],
};

/// Descriptor for `Order`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderDescriptor = $convert.base64Decode(
    'CgVPcmRlchIdCgpzdG9yZV9jb2RlGAEgASgJUglzdG9yZUNvZGUSIQoMb3JkZXJfbnVtYmVyGA'
    'IgASgFUgtvcmRlck51bWJlchIkCgZzdGF0dXMYAyABKA4yDC5PcmRlclN0YXR1c1IGc3RhdHVz'
    'EiAKBWl0ZW1zGAQgAygLMgouT3JkZXJJdGVtUgVpdGVtcw==');

@$core.Deprecated('Use createOrderRequestDescriptor instead')
const CreateOrderRequest$json = {
  '1': 'CreateOrderRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'dine_in', '3': 2, '4': 1, '5': 8, '10': 'dineIn'},
    {'1': 'items', '3': 3, '4': 3, '5': 11, '6': '.OrderItem', '10': 'items'},
    {'1': 'total_price', '3': 4, '4': 1, '5': 5, '10': 'totalPrice'},
  ],
};

/// Descriptor for `CreateOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrderRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVPcmRlclJlcXVlc3QSHQoKc3RvcmVfY29kZRgBIAEoCVIJc3RvcmVDb2RlEhcKB2'
    'RpbmVfaW4YAiABKAhSBmRpbmVJbhIgCgVpdGVtcxgDIAMoCzIKLk9yZGVySXRlbVIFaXRlbXMS'
    'HwoLdG90YWxfcHJpY2UYBCABKAVSCnRvdGFsUHJpY2U=');

@$core.Deprecated('Use getOrderStatusRequestDescriptor instead')
const GetOrderStatusRequest$json = {
  '1': 'GetOrderStatusRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'order_number', '3': 2, '4': 1, '5': 5, '10': 'orderNumber'},
  ],
};

/// Descriptor for `GetOrderStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderStatusRequestDescriptor = $convert.base64Decode(
    'ChVHZXRPcmRlclN0YXR1c1JlcXVlc3QSHQoKc3RvcmVfY29kZRgBIAEoCVIJc3RvcmVDb2RlEi'
    'EKDG9yZGVyX251bWJlchgCIAEoBVILb3JkZXJOdW1iZXI=');

@$core.Deprecated('Use getOrderListRequestDescriptor instead')
const GetOrderListRequest$json = {
  '1': 'GetOrderListRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
  ],
};

/// Descriptor for `GetOrderListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderListRequestDescriptor = $convert.base64Decode(
    'ChNHZXRPcmRlckxpc3RSZXF1ZXN0Eh0KCnN0b3JlX2NvZGUYASABKAlSCXN0b3JlQ29kZQ==');

@$core.Deprecated('Use updateOrderStatusRequestDescriptor instead')
const UpdateOrderStatusRequest$json = {
  '1': 'UpdateOrderStatusRequest',
  '2': [
    {'1': 'store_code', '3': 1, '4': 1, '5': 9, '10': 'storeCode'},
    {'1': 'order_number', '3': 2, '4': 1, '5': 5, '10': 'orderNumber'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.OrderStatus', '10': 'status'},
  ],
};

/// Descriptor for `UpdateOrderStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateOrderStatusRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVPcmRlclN0YXR1c1JlcXVlc3QSHQoKc3RvcmVfY29kZRgBIAEoCVIJc3RvcmVDb2'
    'RlEiEKDG9yZGVyX251bWJlchgCIAEoBVILb3JkZXJOdW1iZXISJAoGc3RhdHVzGAMgASgOMgwu'
    'T3JkZXJTdGF0dXNSBnN0YXR1cw==');

@$core.Deprecated('Use createOrderResponseDescriptor instead')
const CreateOrderResponse$json = {
  '1': 'CreateOrderResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'order_number', '3': 3, '4': 1, '5': 5, '10': 'orderNumber'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `CreateOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOrderResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVPcmRlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIgoFZXJyb3'
    'IYAiABKA4yBy5FRXJyb3JIAFIFZXJyb3KIAQESIQoMb3JkZXJfbnVtYmVyGAMgASgFUgtvcmRl'
    'ck51bWJlckIICgZfZXJyb3I=');

@$core.Deprecated('Use getOrderStatusResponseDescriptor instead')
const GetOrderStatusResponse$json = {
  '1': 'GetOrderStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.OrderStatus', '10': 'status'},
    {'1': 'dine_in', '3': 4, '4': 1, '5': 8, '10': 'dineIn'},
    {'1': 'items', '3': 5, '4': 3, '5': 11, '6': '.OrderItem', '10': 'items'},
    {'1': 'total_price', '3': 6, '4': 1, '5': 5, '10': 'totalPrice'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `GetOrderStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderStatusResponseDescriptor = $convert.base64Decode(
    'ChZHZXRPcmRlclN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIgoFZX'
    'Jyb3IYAiABKA4yBy5FRXJyb3JIAFIFZXJyb3KIAQESJAoGc3RhdHVzGAMgASgOMgwuT3JkZXJT'
    'dGF0dXNSBnN0YXR1cxIXCgdkaW5lX2luGAQgASgIUgZkaW5lSW4SIAoFaXRlbXMYBSADKAsyCi'
    '5PcmRlckl0ZW1SBWl0ZW1zEh8KC3RvdGFsX3ByaWNlGAYgASgFUgp0b3RhbFByaWNlQggKBl9l'
    'cnJvcg==');

@$core.Deprecated('Use getOrderListResponseDescriptor instead')
const GetOrderListResponse$json = {
  '1': 'GetOrderListResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'orders', '3': 3, '4': 3, '5': 11, '6': '.ViewOrderSummary', '10': 'orders'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `GetOrderListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOrderListResponseDescriptor = $convert.base64Decode(
    'ChRHZXRPcmRlckxpc3RSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiIKBWVycm'
    '9yGAIgASgOMgcuRUVycm9ySABSBWVycm9yiAEBEikKBm9yZGVycxgDIAMoCzIRLlZpZXdPcmRl'
    'clN1bW1hcnlSBm9yZGVyc0IICgZfZXJyb3I=');

@$core.Deprecated('Use updateOrderStatusResponseDescriptor instead')
const UpdateOrderStatusResponse$json = {
  '1': 'UpdateOrderStatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 14, '6': '.EError', '9': 0, '10': 'error', '17': true},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.OrderStatus', '10': 'status'},
  ],
  '8': [
    {'1': '_error'},
  ],
};

/// Descriptor for `UpdateOrderStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateOrderStatusResponseDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVPcmRlclN0YXR1c1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSIg'
    'oFZXJyb3IYAiABKA4yBy5FRXJyb3JIAFIFZXJyb3KIAQESJAoGc3RhdHVzGAMgASgOMgwuT3Jk'
    'ZXJTdGF0dXNSBnN0YXR1c0IICgZfZXJyb3I=');

