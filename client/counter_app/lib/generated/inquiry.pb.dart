//
//  Generated code. Do not modify.
//  source: inquiry.proto
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

class InquiryRequest extends $pb.GeneratedMessage {
  factory InquiryRequest({
    $core.String? storeCode,
    $core.Iterable<$core.double>? frameData,
    $core.String? inquiryType,
    $core.int? num,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (frameData != null) {
      $result.frameData.addAll(frameData);
    }
    if (inquiryType != null) {
      $result.inquiryType = inquiryType;
    }
    if (num != null) {
      $result.num = num;
    }
    return $result;
  }
  InquiryRequest._() : super();
  factory InquiryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InquiryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InquiryRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..p<$core.double>(2, _omitFieldNames ? '' : 'frameData', $pb.PbFieldType.KF)
    ..aOS(3, _omitFieldNames ? '' : 'inquiryType')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'num', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InquiryRequest clone() => InquiryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InquiryRequest copyWith(void Function(InquiryRequest) updates) => super.copyWith((message) => updates(message as InquiryRequest)) as InquiryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InquiryRequest create() => InquiryRequest._();
  InquiryRequest createEmptyInstance() => create();
  static $pb.PbList<InquiryRequest> createRepeated() => $pb.PbList<InquiryRequest>();
  @$core.pragma('dart2js:noInline')
  static InquiryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InquiryRequest>(create);
  static InquiryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.double> get frameData => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get inquiryType => $_getSZ(2);
  @$pb.TagNumber(3)
  set inquiryType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInquiryType() => $_has(2);
  @$pb.TagNumber(3)
  void clearInquiryType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get num => $_getIZ(3);
  @$pb.TagNumber(4)
  set num($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNum() => $_has(3);
  @$pb.TagNumber(4)
  void clearNum() => $_clearField(4);
}

class InquiryResponse extends $pb.GeneratedMessage {
  factory InquiryResponse({
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
  InquiryResponse._() : super();
  factory InquiryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InquiryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InquiryResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InquiryResponse clone() => InquiryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InquiryResponse copyWith(void Function(InquiryResponse) updates) => super.copyWith((message) => updates(message as InquiryResponse)) as InquiryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InquiryResponse create() => InquiryResponse._();
  InquiryResponse createEmptyInstance() => create();
  static $pb.PbList<InquiryResponse> createRepeated() => $pb.PbList<InquiryResponse>();
  @$core.pragma('dart2js:noInline')
  static InquiryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InquiryResponse>(create);
  static InquiryResponse? _defaultInstance;

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

class FastInquiryRespIsNoRequest extends $pb.GeneratedMessage {
  factory FastInquiryRespIsNoRequest({
    $core.String? storeCode,
    $core.String? title,
    $core.int? num,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (title != null) {
      $result.title = title;
    }
    if (num != null) {
      $result.num = num;
    }
    return $result;
  }
  FastInquiryRespIsNoRequest._() : super();
  factory FastInquiryRespIsNoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FastInquiryRespIsNoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FastInquiryRespIsNoRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'num', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FastInquiryRespIsNoRequest clone() => FastInquiryRespIsNoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FastInquiryRespIsNoRequest copyWith(void Function(FastInquiryRespIsNoRequest) updates) => super.copyWith((message) => updates(message as FastInquiryRespIsNoRequest)) as FastInquiryRespIsNoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FastInquiryRespIsNoRequest create() => FastInquiryRespIsNoRequest._();
  FastInquiryRespIsNoRequest createEmptyInstance() => create();
  static $pb.PbList<FastInquiryRespIsNoRequest> createRepeated() => $pb.PbList<FastInquiryRespIsNoRequest>();
  @$core.pragma('dart2js:noInline')
  static FastInquiryRespIsNoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FastInquiryRespIsNoRequest>(create);
  static FastInquiryRespIsNoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get num => $_getIZ(2);
  @$pb.TagNumber(3)
  set num($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNum() => $_has(2);
  @$pb.TagNumber(3)
  void clearNum() => $_clearField(3);
}

class FastInquiryRespIsNoResponse extends $pb.GeneratedMessage {
  factory FastInquiryRespIsNoResponse({
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
  FastInquiryRespIsNoResponse._() : super();
  factory FastInquiryRespIsNoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FastInquiryRespIsNoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FastInquiryRespIsNoResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FastInquiryRespIsNoResponse clone() => FastInquiryRespIsNoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FastInquiryRespIsNoResponse copyWith(void Function(FastInquiryRespIsNoResponse) updates) => super.copyWith((message) => updates(message as FastInquiryRespIsNoResponse)) as FastInquiryRespIsNoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FastInquiryRespIsNoResponse create() => FastInquiryRespIsNoResponse._();
  FastInquiryRespIsNoResponse createEmptyInstance() => create();
  static $pb.PbList<FastInquiryRespIsNoResponse> createRepeated() => $pb.PbList<FastInquiryRespIsNoResponse>();
  @$core.pragma('dart2js:noInline')
  static FastInquiryRespIsNoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FastInquiryRespIsNoResponse>(create);
  static FastInquiryRespIsNoResponse? _defaultInstance;

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
