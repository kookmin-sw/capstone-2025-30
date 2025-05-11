//
//  Generated code. Do not modify.
//  source: order.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// 주문 상태
class OrderStatus extends $pb.ProtobufEnum {
  static const OrderStatus ORDER_UNSPECIFIED = OrderStatus._(0, _omitEnumNames ? '' : 'ORDER_UNSPECIFIED');
  static const OrderStatus ORDER_PENDING = OrderStatus._(1, _omitEnumNames ? '' : 'ORDER_PENDING');
  static const OrderStatus ORDER_PROCESSING = OrderStatus._(2, _omitEnumNames ? '' : 'ORDER_PROCESSING');
  static const OrderStatus ORDER_DONE = OrderStatus._(3, _omitEnumNames ? '' : 'ORDER_DONE');

  static const $core.List<OrderStatus> values = <OrderStatus> [
    ORDER_UNSPECIFIED,
    ORDER_PENDING,
    ORDER_PROCESSING,
    ORDER_DONE,
  ];

  static final $core.Map<$core.int, OrderStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OrderStatus? valueOf($core.int value) => _byValue[value];

  const OrderStatus._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
