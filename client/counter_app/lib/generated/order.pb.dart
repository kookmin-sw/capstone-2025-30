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

import 'error.pbenum.dart' as $9;
import 'order.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'order.pbenum.dart';

/// 옵션 선택
class ItemOptions extends $pb.GeneratedMessage {
  factory ItemOptions({
    $pb.PbMap<$core.String, $core.String>? choices,
  }) {
    final $result = create();
    if (choices != null) {
      $result.choices.addAll(choices);
    }
    return $result;
  }
  ItemOptions._() : super();
  factory ItemOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ItemOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ItemOptions', createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'choices', entryClassName: 'ItemOptions.ChoicesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ItemOptions clone() => ItemOptions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ItemOptions copyWith(void Function(ItemOptions) updates) => super.copyWith((message) => updates(message as ItemOptions)) as ItemOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ItemOptions create() => ItemOptions._();
  ItemOptions createEmptyInstance() => create();
  static $pb.PbList<ItemOptions> createRepeated() => $pb.PbList<ItemOptions>();
  @$core.pragma('dart2js:noInline')
  static ItemOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ItemOptions>(create);
  static ItemOptions? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $core.String> get choices => $_getMap(0);
}

/// 주문 야이템
class OrderItem extends $pb.GeneratedMessage {
  factory OrderItem({
    $core.String? name,
    $core.int? quantity,
    ItemOptions? options,
    $core.int? itemPrice,
    $core.String? image,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (options != null) {
      $result.options = options;
    }
    if (itemPrice != null) {
      $result.itemPrice = itemPrice;
    }
    if (image != null) {
      $result.image = image;
    }
    return $result;
  }
  OrderItem._() : super();
  factory OrderItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrderItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrderItem', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aOM<ItemOptions>(3, _omitFieldNames ? '' : 'options', subBuilder: ItemOptions.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemPrice', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'image')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrderItem clone() => OrderItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrderItem copyWith(void Function(OrderItem) updates) => super.copyWith((message) => updates(message as OrderItem)) as OrderItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderItem create() => OrderItem._();
  OrderItem createEmptyInstance() => create();
  static $pb.PbList<OrderItem> createRepeated() => $pb.PbList<OrderItem>();
  @$core.pragma('dart2js:noInline')
  static OrderItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrderItem>(create);
  static OrderItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get quantity => $_getIZ(1);
  @$pb.TagNumber(2)
  set quantity($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuantity() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantity() => $_clearField(2);

  @$pb.TagNumber(3)
  ItemOptions get options => $_getN(2);
  @$pb.TagNumber(3)
  set options(ItemOptions v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOptions() => $_has(2);
  @$pb.TagNumber(3)
  void clearOptions() => $_clearField(3);
  @$pb.TagNumber(3)
  ItemOptions ensureOptions() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get itemPrice => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemPrice($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasItemPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemPrice() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get image => $_getSZ(4);
  @$pb.TagNumber(5)
  set image($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearImage() => $_clearField(5);
}

class ViewOrderSummary extends $pb.GeneratedMessage {
  factory ViewOrderSummary({
    $core.int? orderNumber,
    OrderStatus? status,
    $core.String? createdAt,
  }) {
    final $result = create();
    if (orderNumber != null) {
      $result.orderNumber = orderNumber;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  ViewOrderSummary._() : super();
  factory ViewOrderSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ViewOrderSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ViewOrderSummary', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'orderNumber', $pb.PbFieldType.O3)
    ..e<OrderStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: OrderStatus.ORDER_UNSPECIFIED, valueOf: OrderStatus.valueOf, enumValues: OrderStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ViewOrderSummary clone() => ViewOrderSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ViewOrderSummary copyWith(void Function(ViewOrderSummary) updates) => super.copyWith((message) => updates(message as ViewOrderSummary)) as ViewOrderSummary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ViewOrderSummary create() => ViewOrderSummary._();
  ViewOrderSummary createEmptyInstance() => create();
  static $pb.PbList<ViewOrderSummary> createRepeated() => $pb.PbList<ViewOrderSummary>();
  @$core.pragma('dart2js:noInline')
  static ViewOrderSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ViewOrderSummary>(create);
  static ViewOrderSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get orderNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set orderNumber($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrderNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  OrderStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(OrderStatus v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get createdAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set createdAt($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => $_clearField(3);
}

/// 주문 내역
class Order extends $pb.GeneratedMessage {
  factory Order({
    $core.String? storeCode,
    $core.int? orderNumber,
    OrderStatus? status,
    $core.Iterable<OrderItem>? items,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (orderNumber != null) {
      $result.orderNumber = orderNumber;
    }
    if (status != null) {
      $result.status = status;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  Order._() : super();
  factory Order.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Order.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Order', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'orderNumber', $pb.PbFieldType.O3)
    ..e<OrderStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: OrderStatus.ORDER_UNSPECIFIED, valueOf: OrderStatus.valueOf, enumValues: OrderStatus.values)
    ..pc<OrderItem>(4, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: OrderItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Order clone() => Order()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Order copyWith(void Function(Order) updates) => super.copyWith((message) => updates(message as Order)) as Order;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Order create() => Order._();
  Order createEmptyInstance() => create();
  static $pb.PbList<Order> createRepeated() => $pb.PbList<Order>();
  @$core.pragma('dart2js:noInline')
  static Order getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Order>(create);
  static Order? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get orderNumber => $_getIZ(1);
  @$pb.TagNumber(2)
  set orderNumber($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrderNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrderNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  OrderStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(OrderStatus v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<OrderItem> get items => $_getList(3);
}

class CreateOrderRequest extends $pb.GeneratedMessage {
  factory CreateOrderRequest({
    $core.String? storeCode,
    $core.bool? dineIn,
    $core.Iterable<OrderItem>? items,
    $core.int? totalPrice,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (dineIn != null) {
      $result.dineIn = dineIn;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    if (totalPrice != null) {
      $result.totalPrice = totalPrice;
    }
    return $result;
  }
  CreateOrderRequest._() : super();
  factory CreateOrderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateOrderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateOrderRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..aOB(2, _omitFieldNames ? '' : 'dineIn')
    ..pc<OrderItem>(3, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: OrderItem.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPrice', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateOrderRequest clone() => CreateOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateOrderRequest copyWith(void Function(CreateOrderRequest) updates) => super.copyWith((message) => updates(message as CreateOrderRequest)) as CreateOrderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrderRequest create() => CreateOrderRequest._();
  CreateOrderRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOrderRequest> createRepeated() => $pb.PbList<CreateOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOrderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateOrderRequest>(create);
  static CreateOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get dineIn => $_getBF(1);
  @$pb.TagNumber(2)
  set dineIn($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDineIn() => $_has(1);
  @$pb.TagNumber(2)
  void clearDineIn() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<OrderItem> get items => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get totalPrice => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPrice($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPrice() => $_clearField(4);
}

class GetOrderStatusRequest extends $pb.GeneratedMessage {
  factory GetOrderStatusRequest({
    $core.String? storeCode,
    $core.int? orderNumber,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (orderNumber != null) {
      $result.orderNumber = orderNumber;
    }
    return $result;
  }
  GetOrderStatusRequest._() : super();
  factory GetOrderStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderStatusRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'orderNumber', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderStatusRequest clone() => GetOrderStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderStatusRequest copyWith(void Function(GetOrderStatusRequest) updates) => super.copyWith((message) => updates(message as GetOrderStatusRequest)) as GetOrderStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderStatusRequest create() => GetOrderStatusRequest._();
  GetOrderStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderStatusRequest> createRepeated() => $pb.PbList<GetOrderStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderStatusRequest>(create);
  static GetOrderStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get orderNumber => $_getIZ(1);
  @$pb.TagNumber(2)
  set orderNumber($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrderNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrderNumber() => $_clearField(2);
}

class GetOrderListRequest extends $pb.GeneratedMessage {
  factory GetOrderListRequest({
    $core.String? storeCode,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    return $result;
  }
  GetOrderListRequest._() : super();
  factory GetOrderListRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderListRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderListRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderListRequest clone() => GetOrderListRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderListRequest copyWith(void Function(GetOrderListRequest) updates) => super.copyWith((message) => updates(message as GetOrderListRequest)) as GetOrderListRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderListRequest create() => GetOrderListRequest._();
  GetOrderListRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderListRequest> createRepeated() => $pb.PbList<GetOrderListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderListRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderListRequest>(create);
  static GetOrderListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);
}

class UpdateOrderStatusRequest extends $pb.GeneratedMessage {
  factory UpdateOrderStatusRequest({
    $core.String? storeCode,
    $core.int? orderNumber,
    OrderStatus? status,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (orderNumber != null) {
      $result.orderNumber = orderNumber;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  UpdateOrderStatusRequest._() : super();
  factory UpdateOrderStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateOrderStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateOrderStatusRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'orderNumber', $pb.PbFieldType.O3)
    ..e<OrderStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: OrderStatus.ORDER_UNSPECIFIED, valueOf: OrderStatus.valueOf, enumValues: OrderStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateOrderStatusRequest clone() => UpdateOrderStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateOrderStatusRequest copyWith(void Function(UpdateOrderStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateOrderStatusRequest)) as UpdateOrderStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateOrderStatusRequest create() => UpdateOrderStatusRequest._();
  UpdateOrderStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateOrderStatusRequest> createRepeated() => $pb.PbList<UpdateOrderStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateOrderStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateOrderStatusRequest>(create);
  static UpdateOrderStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get orderNumber => $_getIZ(1);
  @$pb.TagNumber(2)
  set orderNumber($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrderNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrderNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  OrderStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(OrderStatus v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

class CreateOrderResponse extends $pb.GeneratedMessage {
  factory CreateOrderResponse({
    $core.bool? success,
    $9.EError? error,
    $core.int? orderNumber,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (orderNumber != null) {
      $result.orderNumber = orderNumber;
    }
    return $result;
  }
  CreateOrderResponse._() : super();
  factory CreateOrderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateOrderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateOrderResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'orderNumber', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateOrderResponse clone() => CreateOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateOrderResponse copyWith(void Function(CreateOrderResponse) updates) => super.copyWith((message) => updates(message as CreateOrderResponse)) as CreateOrderResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOrderResponse create() => CreateOrderResponse._();
  CreateOrderResponse createEmptyInstance() => create();
  static $pb.PbList<CreateOrderResponse> createRepeated() => $pb.PbList<CreateOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateOrderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateOrderResponse>(create);
  static CreateOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $9.EError get error => $_getN(1);
  @$pb.TagNumber(2)
  set error($9.EError v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get orderNumber => $_getIZ(2);
  @$pb.TagNumber(3)
  set orderNumber($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOrderNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearOrderNumber() => $_clearField(3);
}

class GetOrderStatusResponse extends $pb.GeneratedMessage {
  factory GetOrderStatusResponse({
    $core.bool? success,
    $9.EError? error,
    OrderStatus? status,
    $core.bool? dineIn,
    $core.Iterable<OrderItem>? items,
    $core.int? totalPrice,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (status != null) {
      $result.status = status;
    }
    if (dineIn != null) {
      $result.dineIn = dineIn;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    if (totalPrice != null) {
      $result.totalPrice = totalPrice;
    }
    return $result;
  }
  GetOrderStatusResponse._() : super();
  factory GetOrderStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderStatusResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..e<OrderStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: OrderStatus.ORDER_UNSPECIFIED, valueOf: OrderStatus.valueOf, enumValues: OrderStatus.values)
    ..aOB(4, _omitFieldNames ? '' : 'dineIn')
    ..pc<OrderItem>(5, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: OrderItem.create)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'totalPrice', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderStatusResponse clone() => GetOrderStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderStatusResponse copyWith(void Function(GetOrderStatusResponse) updates) => super.copyWith((message) => updates(message as GetOrderStatusResponse)) as GetOrderStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderStatusResponse create() => GetOrderStatusResponse._();
  GetOrderStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderStatusResponse> createRepeated() => $pb.PbList<GetOrderStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderStatusResponse>(create);
  static GetOrderStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $9.EError get error => $_getN(1);
  @$pb.TagNumber(2)
  set error($9.EError v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);

  @$pb.TagNumber(3)
  OrderStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(OrderStatus v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get dineIn => $_getBF(3);
  @$pb.TagNumber(4)
  set dineIn($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDineIn() => $_has(3);
  @$pb.TagNumber(4)
  void clearDineIn() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<OrderItem> get items => $_getList(4);

  @$pb.TagNumber(6)
  $core.int get totalPrice => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalPrice($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalPrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalPrice() => $_clearField(6);
}

class GetOrderListResponse extends $pb.GeneratedMessage {
  factory GetOrderListResponse({
    $core.bool? success,
    $9.EError? error,
    $core.Iterable<ViewOrderSummary>? orders,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (orders != null) {
      $result.orders.addAll(orders);
    }
    return $result;
  }
  GetOrderListResponse._() : super();
  factory GetOrderListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderListResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..pc<ViewOrderSummary>(3, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM, subBuilder: ViewOrderSummary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderListResponse clone() => GetOrderListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderListResponse copyWith(void Function(GetOrderListResponse) updates) => super.copyWith((message) => updates(message as GetOrderListResponse)) as GetOrderListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderListResponse create() => GetOrderListResponse._();
  GetOrderListResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderListResponse> createRepeated() => $pb.PbList<GetOrderListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderListResponse>(create);
  static GetOrderListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $9.EError get error => $_getN(1);
  @$pb.TagNumber(2)
  set error($9.EError v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<ViewOrderSummary> get orders => $_getList(2);
}

class UpdateOrderStatusResponse extends $pb.GeneratedMessage {
  factory UpdateOrderStatusResponse({
    $core.bool? success,
    $9.EError? error,
    OrderStatus? status,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  UpdateOrderStatusResponse._() : super();
  factory UpdateOrderStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateOrderStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateOrderStatusResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..e<OrderStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: OrderStatus.ORDER_UNSPECIFIED, valueOf: OrderStatus.valueOf, enumValues: OrderStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateOrderStatusResponse clone() => UpdateOrderStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateOrderStatusResponse copyWith(void Function(UpdateOrderStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateOrderStatusResponse)) as UpdateOrderStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateOrderStatusResponse create() => UpdateOrderStatusResponse._();
  UpdateOrderStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateOrderStatusResponse> createRepeated() => $pb.PbList<UpdateOrderStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateOrderStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateOrderStatusResponse>(create);
  static UpdateOrderStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $9.EError get error => $_getN(1);
  @$pb.TagNumber(2)
  set error($9.EError v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);

  @$pb.TagNumber(3)
  OrderStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(OrderStatus v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
