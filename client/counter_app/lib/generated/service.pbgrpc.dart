//
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/empty.pb.dart' as $4;
import 'inquiry.pb.dart' as $5;
import 'menu.pb.dart' as $6;
import 'message.pb.dart' as $8;
import 'order.pb.dart' as $7;
import 'store.pb.dart' as $3;
import 'test.pb.dart' as $2;

export 'service.pb.dart';

@$pb.GrpcServiceName('APIService')
class APIServiceClient extends $grpc.Client {
  static final _$addTestStruct = $grpc.ClientMethod<$2.AddTestStructRequest, $2.AddTestStructResponse>(
      '/APIService/AddTestStruct',
      ($2.AddTestStructRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AddTestStructResponse.fromBuffer(value));
  static final _$createStore = $grpc.ClientMethod<$3.CreateStoreRequest, $3.CreateStoreResponse>(
      '/APIService/CreateStore',
      ($3.CreateStoreRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.CreateStoreResponse.fromBuffer(value));
  static final _$getStoreList = $grpc.ClientMethod<$4.Empty, $3.GetStoreListResponse>(
      '/APIService/GetStoreList',
      ($4.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetStoreListResponse.fromBuffer(value));
  static final _$getStore = $grpc.ClientMethod<$3.GetStoreRequest, $3.GetStoreResponse>(
      '/APIService/GetStore',
      ($3.GetStoreRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetStoreResponse.fromBuffer(value));
  static final _$updateStore = $grpc.ClientMethod<$3.UpdateStoreRequest, $3.UpdateStoreResponse>(
      '/APIService/UpdateStore',
      ($3.UpdateStoreRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.UpdateStoreResponse.fromBuffer(value));
  static final _$deleteStore = $grpc.ClientMethod<$3.DeleteStoreRequest, $3.DeleteStoreResponse>(
      '/APIService/DeleteStore',
      ($3.DeleteStoreRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.DeleteStoreResponse.fromBuffer(value));
  static final _$streamInquiries = $grpc.ClientMethod<$5.InquiryRequest, $5.InquiryResponse>(
      '/APIService/StreamInquiries',
      ($5.InquiryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.InquiryResponse.fromBuffer(value));
  static final _$fastInquiryRespIsNo = $grpc.ClientMethod<$5.FastInquiryRespIsNoRequest, $5.FastInquiryRespIsNoResponse>(
      '/APIService/FastInquiryRespIsNo',
      ($5.FastInquiryRespIsNoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.FastInquiryRespIsNoResponse.fromBuffer(value));
  static final _$createMenu = $grpc.ClientMethod<$6.CreateMenuRequest, $6.CreateMenuResponse>(
      '/APIService/CreateMenu',
      ($6.CreateMenuRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.CreateMenuResponse.fromBuffer(value));
  static final _$getCategoryList = $grpc.ClientMethod<$6.GetCategoryListRequest, $6.GetCategoryListResponse>(
      '/APIService/GetCategoryList',
      ($6.GetCategoryListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetCategoryListResponse.fromBuffer(value));
  static final _$getMenuList = $grpc.ClientMethod<$6.GetMenuListRequest, $6.GetMenuListResponse>(
      '/APIService/GetMenuList',
      ($6.GetMenuListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetMenuListResponse.fromBuffer(value));
  static final _$getMenuDetail = $grpc.ClientMethod<$6.GetMenuDetailRequest, $6.GetMenuDetailResponse>(
      '/APIService/GetMenuDetail',
      ($6.GetMenuDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.GetMenuDetailResponse.fromBuffer(value));
  static final _$createOrder = $grpc.ClientMethod<$7.CreateOrderRequest, $7.CreateOrderResponse>(
      '/APIService/CreateOrder',
      ($7.CreateOrderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.CreateOrderResponse.fromBuffer(value));
  static final _$getOrderStatus = $grpc.ClientMethod<$7.GetOrderStatusRequest, $7.GetOrderStatusResponse>(
      '/APIService/GetOrderStatus',
      ($7.GetOrderStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.GetOrderStatusResponse.fromBuffer(value));
  static final _$getOrderList = $grpc.ClientMethod<$7.GetOrderListRequest, $7.GetOrderListResponse>(
      '/APIService/GetOrderList',
      ($7.GetOrderListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.GetOrderListResponse.fromBuffer(value));
  static final _$updateOrderStatus = $grpc.ClientMethod<$7.UpdateOrderStatusRequest, $7.UpdateOrderStatusResponse>(
      '/APIService/UpdateOrderStatus',
      ($7.UpdateOrderStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.UpdateOrderStatusResponse.fromBuffer(value));
  static final _$getMessages = $grpc.ClientMethod<$8.GetMessagesRequest, $8.GetMessagesResponse>(
      '/APIService/GetMessages',
      ($8.GetMessagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.GetMessagesResponse.fromBuffer(value));
  static final _$getChatRoomList = $grpc.ClientMethod<$8.GetChatRoomListRequest, $8.GetChatRoomListResponse>(
      '/APIService/GetChatRoomList',
      ($8.GetChatRoomListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.GetChatRoomListResponse.fromBuffer(value));

  APIServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.AddTestStructResponse> addTestStruct($2.AddTestStructRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTestStruct, request, options: options);
  }

  $grpc.ResponseFuture<$3.CreateStoreResponse> createStore($3.CreateStoreRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createStore, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetStoreListResponse> getStoreList($4.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStoreList, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetStoreResponse> getStore($3.GetStoreRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getStore, request, options: options);
  }

  $grpc.ResponseFuture<$3.UpdateStoreResponse> updateStore($3.UpdateStoreRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateStore, request, options: options);
  }

  $grpc.ResponseFuture<$3.DeleteStoreResponse> deleteStore($3.DeleteStoreRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteStore, request, options: options);
  }

  $grpc.ResponseFuture<$5.InquiryResponse> streamInquiries($async.Stream<$5.InquiryRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamInquiries, request, options: options).single;
  }

  $grpc.ResponseFuture<$5.FastInquiryRespIsNoResponse> fastInquiryRespIsNo($5.FastInquiryRespIsNoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fastInquiryRespIsNo, request, options: options);
  }

  $grpc.ResponseFuture<$6.CreateMenuResponse> createMenu($6.CreateMenuRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createMenu, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetCategoryListResponse> getCategoryList($6.GetCategoryListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryList, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetMenuListResponse> getMenuList($6.GetMenuListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMenuList, request, options: options);
  }

  $grpc.ResponseFuture<$6.GetMenuDetailResponse> getMenuDetail($6.GetMenuDetailRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMenuDetail, request, options: options);
  }

  $grpc.ResponseFuture<$7.CreateOrderResponse> createOrder($7.CreateOrderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrder, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetOrderStatusResponse> getOrderStatus($7.GetOrderStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderStatus, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetOrderListResponse> getOrderList($7.GetOrderListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderList, request, options: options);
  }

  $grpc.ResponseFuture<$7.UpdateOrderStatusResponse> updateOrderStatus($7.UpdateOrderStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateOrderStatus, request, options: options);
  }

  $grpc.ResponseFuture<$8.GetMessagesResponse> getMessages($8.GetMessagesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMessages, request, options: options);
  }

  $grpc.ResponseFuture<$8.GetChatRoomListResponse> getChatRoomList($8.GetChatRoomListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChatRoomList, request, options: options);
  }
}

@$pb.GrpcServiceName('APIService')
abstract class APIServiceBase extends $grpc.Service {
  $core.String get $name => 'APIService';

  APIServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.AddTestStructRequest, $2.AddTestStructResponse>(
        'AddTestStruct',
        addTestStruct_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AddTestStructRequest.fromBuffer(value),
        ($2.AddTestStructResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.CreateStoreRequest, $3.CreateStoreResponse>(
        'CreateStore',
        createStore_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.CreateStoreRequest.fromBuffer(value),
        ($3.CreateStoreResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.Empty, $3.GetStoreListResponse>(
        'GetStoreList',
        getStoreList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.Empty.fromBuffer(value),
        ($3.GetStoreListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetStoreRequest, $3.GetStoreResponse>(
        'GetStore',
        getStore_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetStoreRequest.fromBuffer(value),
        ($3.GetStoreResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UpdateStoreRequest, $3.UpdateStoreResponse>(
        'UpdateStore',
        updateStore_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.UpdateStoreRequest.fromBuffer(value),
        ($3.UpdateStoreResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.DeleteStoreRequest, $3.DeleteStoreResponse>(
        'DeleteStore',
        deleteStore_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.DeleteStoreRequest.fromBuffer(value),
        ($3.DeleteStoreResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.InquiryRequest, $5.InquiryResponse>(
        'StreamInquiries',
        streamInquiries,
        true,
        false,
        ($core.List<$core.int> value) => $5.InquiryRequest.fromBuffer(value),
        ($5.InquiryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.FastInquiryRespIsNoRequest, $5.FastInquiryRespIsNoResponse>(
        'FastInquiryRespIsNo',
        fastInquiryRespIsNo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.FastInquiryRespIsNoRequest.fromBuffer(value),
        ($5.FastInquiryRespIsNoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.CreateMenuRequest, $6.CreateMenuResponse>(
        'CreateMenu',
        createMenu_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.CreateMenuRequest.fromBuffer(value),
        ($6.CreateMenuResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetCategoryListRequest, $6.GetCategoryListResponse>(
        'GetCategoryList',
        getCategoryList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetCategoryListRequest.fromBuffer(value),
        ($6.GetCategoryListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetMenuListRequest, $6.GetMenuListResponse>(
        'GetMenuList',
        getMenuList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetMenuListRequest.fromBuffer(value),
        ($6.GetMenuListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.GetMenuDetailRequest, $6.GetMenuDetailResponse>(
        'GetMenuDetail',
        getMenuDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetMenuDetailRequest.fromBuffer(value),
        ($6.GetMenuDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.CreateOrderRequest, $7.CreateOrderResponse>(
        'CreateOrder',
        createOrder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.CreateOrderRequest.fromBuffer(value),
        ($7.CreateOrderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetOrderStatusRequest, $7.GetOrderStatusResponse>(
        'GetOrderStatus',
        getOrderStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetOrderStatusRequest.fromBuffer(value),
        ($7.GetOrderStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetOrderListRequest, $7.GetOrderListResponse>(
        'GetOrderList',
        getOrderList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetOrderListRequest.fromBuffer(value),
        ($7.GetOrderListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.UpdateOrderStatusRequest, $7.UpdateOrderStatusResponse>(
        'UpdateOrderStatus',
        updateOrderStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.UpdateOrderStatusRequest.fromBuffer(value),
        ($7.UpdateOrderStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.GetMessagesRequest, $8.GetMessagesResponse>(
        'GetMessages',
        getMessages_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.GetMessagesRequest.fromBuffer(value),
        ($8.GetMessagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.GetChatRoomListRequest, $8.GetChatRoomListResponse>(
        'GetChatRoomList',
        getChatRoomList_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.GetChatRoomListRequest.fromBuffer(value),
        ($8.GetChatRoomListResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.AddTestStructResponse> addTestStruct_Pre($grpc.ServiceCall $call, $async.Future<$2.AddTestStructRequest> $request) async {
    return addTestStruct($call, await $request);
  }

  $async.Future<$3.CreateStoreResponse> createStore_Pre($grpc.ServiceCall $call, $async.Future<$3.CreateStoreRequest> $request) async {
    return createStore($call, await $request);
  }

  $async.Future<$3.GetStoreListResponse> getStoreList_Pre($grpc.ServiceCall $call, $async.Future<$4.Empty> $request) async {
    return getStoreList($call, await $request);
  }

  $async.Future<$3.GetStoreResponse> getStore_Pre($grpc.ServiceCall $call, $async.Future<$3.GetStoreRequest> $request) async {
    return getStore($call, await $request);
  }

  $async.Future<$3.UpdateStoreResponse> updateStore_Pre($grpc.ServiceCall $call, $async.Future<$3.UpdateStoreRequest> $request) async {
    return updateStore($call, await $request);
  }

  $async.Future<$3.DeleteStoreResponse> deleteStore_Pre($grpc.ServiceCall $call, $async.Future<$3.DeleteStoreRequest> $request) async {
    return deleteStore($call, await $request);
  }

  $async.Future<$5.FastInquiryRespIsNoResponse> fastInquiryRespIsNo_Pre($grpc.ServiceCall $call, $async.Future<$5.FastInquiryRespIsNoRequest> $request) async {
    return fastInquiryRespIsNo($call, await $request);
  }

  $async.Future<$6.CreateMenuResponse> createMenu_Pre($grpc.ServiceCall $call, $async.Future<$6.CreateMenuRequest> $request) async {
    return createMenu($call, await $request);
  }

  $async.Future<$6.GetCategoryListResponse> getCategoryList_Pre($grpc.ServiceCall $call, $async.Future<$6.GetCategoryListRequest> $request) async {
    return getCategoryList($call, await $request);
  }

  $async.Future<$6.GetMenuListResponse> getMenuList_Pre($grpc.ServiceCall $call, $async.Future<$6.GetMenuListRequest> $request) async {
    return getMenuList($call, await $request);
  }

  $async.Future<$6.GetMenuDetailResponse> getMenuDetail_Pre($grpc.ServiceCall $call, $async.Future<$6.GetMenuDetailRequest> $request) async {
    return getMenuDetail($call, await $request);
  }

  $async.Future<$7.CreateOrderResponse> createOrder_Pre($grpc.ServiceCall $call, $async.Future<$7.CreateOrderRequest> $request) async {
    return createOrder($call, await $request);
  }

  $async.Future<$7.GetOrderStatusResponse> getOrderStatus_Pre($grpc.ServiceCall $call, $async.Future<$7.GetOrderStatusRequest> $request) async {
    return getOrderStatus($call, await $request);
  }

  $async.Future<$7.GetOrderListResponse> getOrderList_Pre($grpc.ServiceCall $call, $async.Future<$7.GetOrderListRequest> $request) async {
    return getOrderList($call, await $request);
  }

  $async.Future<$7.UpdateOrderStatusResponse> updateOrderStatus_Pre($grpc.ServiceCall $call, $async.Future<$7.UpdateOrderStatusRequest> $request) async {
    return updateOrderStatus($call, await $request);
  }

  $async.Future<$8.GetMessagesResponse> getMessages_Pre($grpc.ServiceCall $call, $async.Future<$8.GetMessagesRequest> $request) async {
    return getMessages($call, await $request);
  }

  $async.Future<$8.GetChatRoomListResponse> getChatRoomList_Pre($grpc.ServiceCall $call, $async.Future<$8.GetChatRoomListRequest> $request) async {
    return getChatRoomList($call, await $request);
  }

  $async.Future<$2.AddTestStructResponse> addTestStruct($grpc.ServiceCall call, $2.AddTestStructRequest request);
  $async.Future<$3.CreateStoreResponse> createStore($grpc.ServiceCall call, $3.CreateStoreRequest request);
  $async.Future<$3.GetStoreListResponse> getStoreList($grpc.ServiceCall call, $4.Empty request);
  $async.Future<$3.GetStoreResponse> getStore($grpc.ServiceCall call, $3.GetStoreRequest request);
  $async.Future<$3.UpdateStoreResponse> updateStore($grpc.ServiceCall call, $3.UpdateStoreRequest request);
  $async.Future<$3.DeleteStoreResponse> deleteStore($grpc.ServiceCall call, $3.DeleteStoreRequest request);
  $async.Future<$5.InquiryResponse> streamInquiries($grpc.ServiceCall call, $async.Stream<$5.InquiryRequest> request);
  $async.Future<$5.FastInquiryRespIsNoResponse> fastInquiryRespIsNo($grpc.ServiceCall call, $5.FastInquiryRespIsNoRequest request);
  $async.Future<$6.CreateMenuResponse> createMenu($grpc.ServiceCall call, $6.CreateMenuRequest request);
  $async.Future<$6.GetCategoryListResponse> getCategoryList($grpc.ServiceCall call, $6.GetCategoryListRequest request);
  $async.Future<$6.GetMenuListResponse> getMenuList($grpc.ServiceCall call, $6.GetMenuListRequest request);
  $async.Future<$6.GetMenuDetailResponse> getMenuDetail($grpc.ServiceCall call, $6.GetMenuDetailRequest request);
  $async.Future<$7.CreateOrderResponse> createOrder($grpc.ServiceCall call, $7.CreateOrderRequest request);
  $async.Future<$7.GetOrderStatusResponse> getOrderStatus($grpc.ServiceCall call, $7.GetOrderStatusRequest request);
  $async.Future<$7.GetOrderListResponse> getOrderList($grpc.ServiceCall call, $7.GetOrderListRequest request);
  $async.Future<$7.UpdateOrderStatusResponse> updateOrderStatus($grpc.ServiceCall call, $7.UpdateOrderStatusRequest request);
  $async.Future<$8.GetMessagesResponse> getMessages($grpc.ServiceCall call, $8.GetMessagesRequest request);
  $async.Future<$8.GetChatRoomListResponse> getChatRoomList($grpc.ServiceCall call, $8.GetChatRoomListRequest request);
}
