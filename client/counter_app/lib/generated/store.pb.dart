//
//  Generated code. Do not modify.
//  source: store.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'error.pbenum.dart' as $9;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ViewStore extends $pb.GeneratedMessage {
  factory ViewStore({
    $core.String? storeCode,
    $core.String? name,
    $core.String? location,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (name != null) {
      $result.name = name;
    }
    if (location != null) {
      $result.location = location;
    }
    return $result;
  }
  ViewStore._() : super();
  factory ViewStore.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ViewStore.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ViewStore', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'location')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ViewStore clone() => ViewStore()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ViewStore copyWith(void Function(ViewStore) updates) => super.copyWith((message) => updates(message as ViewStore)) as ViewStore;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ViewStore create() => ViewStore._();
  ViewStore createEmptyInstance() => create();
  static $pb.PbList<ViewStore> createRepeated() => $pb.PbList<ViewStore>();
  @$core.pragma('dart2js:noInline')
  static ViewStore getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ViewStore>(create);
  static ViewStore? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get location => $_getSZ(2);
  @$pb.TagNumber(3)
  set location($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocation() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocation() => $_clearField(3);
}

class CreateStoreRequest extends $pb.GeneratedMessage {
  factory CreateStoreRequest({
    $core.String? name,
    $core.String? location,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (location != null) {
      $result.location = location;
    }
    return $result;
  }
  CreateStoreRequest._() : super();
  factory CreateStoreRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateStoreRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateStoreRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'location')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateStoreRequest clone() => CreateStoreRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateStoreRequest copyWith(void Function(CreateStoreRequest) updates) => super.copyWith((message) => updates(message as CreateStoreRequest)) as CreateStoreRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateStoreRequest create() => CreateStoreRequest._();
  CreateStoreRequest createEmptyInstance() => create();
  static $pb.PbList<CreateStoreRequest> createRepeated() => $pb.PbList<CreateStoreRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateStoreRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateStoreRequest>(create);
  static CreateStoreRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get location => $_getSZ(1);
  @$pb.TagNumber(2)
  set location($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => $_clearField(2);
}

class UpdateStoreRequest extends $pb.GeneratedMessage {
  factory UpdateStoreRequest({
    $core.String? storeCode,
    $core.String? name,
    $core.String? location,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (name != null) {
      $result.name = name;
    }
    if (location != null) {
      $result.location = location;
    }
    return $result;
  }
  UpdateStoreRequest._() : super();
  factory UpdateStoreRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateStoreRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateStoreRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'location')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateStoreRequest clone() => UpdateStoreRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateStoreRequest copyWith(void Function(UpdateStoreRequest) updates) => super.copyWith((message) => updates(message as UpdateStoreRequest)) as UpdateStoreRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateStoreRequest create() => UpdateStoreRequest._();
  UpdateStoreRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateStoreRequest> createRepeated() => $pb.PbList<UpdateStoreRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateStoreRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateStoreRequest>(create);
  static UpdateStoreRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get location => $_getSZ(2);
  @$pb.TagNumber(3)
  set location($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocation() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocation() => $_clearField(3);
}

class GetStoreRequest extends $pb.GeneratedMessage {
  factory GetStoreRequest({
    $core.String? storeCode,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    return $result;
  }
  GetStoreRequest._() : super();
  factory GetStoreRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStoreRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStoreRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStoreRequest clone() => GetStoreRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStoreRequest copyWith(void Function(GetStoreRequest) updates) => super.copyWith((message) => updates(message as GetStoreRequest)) as GetStoreRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStoreRequest create() => GetStoreRequest._();
  GetStoreRequest createEmptyInstance() => create();
  static $pb.PbList<GetStoreRequest> createRepeated() => $pb.PbList<GetStoreRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStoreRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStoreRequest>(create);
  static GetStoreRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);
}

class DeleteStoreRequest extends $pb.GeneratedMessage {
  factory DeleteStoreRequest({
    $core.String? storeCode,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    return $result;
  }
  DeleteStoreRequest._() : super();
  factory DeleteStoreRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteStoreRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteStoreRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteStoreRequest clone() => DeleteStoreRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteStoreRequest copyWith(void Function(DeleteStoreRequest) updates) => super.copyWith((message) => updates(message as DeleteStoreRequest)) as DeleteStoreRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteStoreRequest create() => DeleteStoreRequest._();
  DeleteStoreRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteStoreRequest> createRepeated() => $pb.PbList<DeleteStoreRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteStoreRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteStoreRequest>(create);
  static DeleteStoreRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);
}

class CreateStoreResponse extends $pb.GeneratedMessage {
  factory CreateStoreResponse({
    $core.bool? success,
    $9.EError? error,
    ViewStore? store,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (store != null) {
      $result.store = store;
    }
    return $result;
  }
  CreateStoreResponse._() : super();
  factory CreateStoreResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateStoreResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateStoreResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..aOM<ViewStore>(3, _omitFieldNames ? '' : 'store', subBuilder: ViewStore.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateStoreResponse clone() => CreateStoreResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateStoreResponse copyWith(void Function(CreateStoreResponse) updates) => super.copyWith((message) => updates(message as CreateStoreResponse)) as CreateStoreResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateStoreResponse create() => CreateStoreResponse._();
  CreateStoreResponse createEmptyInstance() => create();
  static $pb.PbList<CreateStoreResponse> createRepeated() => $pb.PbList<CreateStoreResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateStoreResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateStoreResponse>(create);
  static CreateStoreResponse? _defaultInstance;

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
  ViewStore get store => $_getN(2);
  @$pb.TagNumber(3)
  set store(ViewStore v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStore() => $_has(2);
  @$pb.TagNumber(3)
  void clearStore() => $_clearField(3);
  @$pb.TagNumber(3)
  ViewStore ensureStore() => $_ensure(2);
}

class GetStoreListResponse extends $pb.GeneratedMessage {
  factory GetStoreListResponse({
    $core.bool? success,
    $9.EError? error,
    $core.Iterable<ViewStore>? stores,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (stores != null) {
      $result.stores.addAll(stores);
    }
    return $result;
  }
  GetStoreListResponse._() : super();
  factory GetStoreListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStoreListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStoreListResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..pc<ViewStore>(3, _omitFieldNames ? '' : 'stores', $pb.PbFieldType.PM, subBuilder: ViewStore.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStoreListResponse clone() => GetStoreListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStoreListResponse copyWith(void Function(GetStoreListResponse) updates) => super.copyWith((message) => updates(message as GetStoreListResponse)) as GetStoreListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStoreListResponse create() => GetStoreListResponse._();
  GetStoreListResponse createEmptyInstance() => create();
  static $pb.PbList<GetStoreListResponse> createRepeated() => $pb.PbList<GetStoreListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStoreListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStoreListResponse>(create);
  static GetStoreListResponse? _defaultInstance;

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
  $pb.PbList<ViewStore> get stores => $_getList(2);
}

class GetStoreResponse extends $pb.GeneratedMessage {
  factory GetStoreResponse({
    $core.bool? success,
    $9.EError? error,
    ViewStore? store,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (store != null) {
      $result.store = store;
    }
    return $result;
  }
  GetStoreResponse._() : super();
  factory GetStoreResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStoreResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStoreResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..aOM<ViewStore>(3, _omitFieldNames ? '' : 'store', subBuilder: ViewStore.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStoreResponse clone() => GetStoreResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStoreResponse copyWith(void Function(GetStoreResponse) updates) => super.copyWith((message) => updates(message as GetStoreResponse)) as GetStoreResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStoreResponse create() => GetStoreResponse._();
  GetStoreResponse createEmptyInstance() => create();
  static $pb.PbList<GetStoreResponse> createRepeated() => $pb.PbList<GetStoreResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStoreResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStoreResponse>(create);
  static GetStoreResponse? _defaultInstance;

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
  ViewStore get store => $_getN(2);
  @$pb.TagNumber(3)
  set store(ViewStore v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStore() => $_has(2);
  @$pb.TagNumber(3)
  void clearStore() => $_clearField(3);
  @$pb.TagNumber(3)
  ViewStore ensureStore() => $_ensure(2);
}

class UpdateStoreResponse extends $pb.GeneratedMessage {
  factory UpdateStoreResponse({
    $core.bool? success,
    $9.EError? error,
    ViewStore? store,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (store != null) {
      $result.store = store;
    }
    return $result;
  }
  UpdateStoreResponse._() : super();
  factory UpdateStoreResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateStoreResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateStoreResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..aOM<ViewStore>(3, _omitFieldNames ? '' : 'store', subBuilder: ViewStore.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateStoreResponse clone() => UpdateStoreResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateStoreResponse copyWith(void Function(UpdateStoreResponse) updates) => super.copyWith((message) => updates(message as UpdateStoreResponse)) as UpdateStoreResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateStoreResponse create() => UpdateStoreResponse._();
  UpdateStoreResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateStoreResponse> createRepeated() => $pb.PbList<UpdateStoreResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateStoreResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateStoreResponse>(create);
  static UpdateStoreResponse? _defaultInstance;

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
  ViewStore get store => $_getN(2);
  @$pb.TagNumber(3)
  set store(ViewStore v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStore() => $_has(2);
  @$pb.TagNumber(3)
  void clearStore() => $_clearField(3);
  @$pb.TagNumber(3)
  ViewStore ensureStore() => $_ensure(2);
}

class DeleteStoreResponse extends $pb.GeneratedMessage {
  factory DeleteStoreResponse({
    $core.bool? success,
    $9.EError? error,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  DeleteStoreResponse._() : super();
  factory DeleteStoreResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteStoreResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteStoreResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteStoreResponse clone() => DeleteStoreResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteStoreResponse copyWith(void Function(DeleteStoreResponse) updates) => super.copyWith((message) => updates(message as DeleteStoreResponse)) as DeleteStoreResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteStoreResponse create() => DeleteStoreResponse._();
  DeleteStoreResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteStoreResponse> createRepeated() => $pb.PbList<DeleteStoreResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteStoreResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteStoreResponse>(create);
  static DeleteStoreResponse? _defaultInstance;

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
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
