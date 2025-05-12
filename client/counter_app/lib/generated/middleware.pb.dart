//
//  Generated code. Do not modify.
//  source: middleware.proto
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

class FrameToMarkingDataRequest extends $pb.GeneratedMessage {
  factory FrameToMarkingDataRequest({
    $core.Iterable<$core.List<$core.int>>? frame,
    $core.String? storeId,
    $core.String? inquiryType,
    $core.int? num,
  }) {
    final $result = create();
    if (frame != null) {
      $result.frame.addAll(frame);
    }
    if (storeId != null) {
      $result.storeId = storeId;
    }
    if (inquiryType != null) {
      $result.inquiryType = inquiryType;
    }
    if (num != null) {
      $result.num = num;
    }
    return $result;
  }
  FrameToMarkingDataRequest._() : super();
  factory FrameToMarkingDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FrameToMarkingDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FrameToMarkingDataRequest', createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'frame', $pb.PbFieldType.PY)
    ..aOS(2, _omitFieldNames ? '' : 'storeId')
    ..aOS(3, _omitFieldNames ? '' : 'inquiryType')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'num', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FrameToMarkingDataRequest clone() => FrameToMarkingDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FrameToMarkingDataRequest copyWith(void Function(FrameToMarkingDataRequest) updates) => super.copyWith((message) => updates(message as FrameToMarkingDataRequest)) as FrameToMarkingDataRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FrameToMarkingDataRequest create() => FrameToMarkingDataRequest._();
  FrameToMarkingDataRequest createEmptyInstance() => create();
  static $pb.PbList<FrameToMarkingDataRequest> createRepeated() => $pb.PbList<FrameToMarkingDataRequest>();
  @$core.pragma('dart2js:noInline')
  static FrameToMarkingDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FrameToMarkingDataRequest>(create);
  static FrameToMarkingDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.List<$core.int>> get frame => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get storeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set storeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStoreId() => $_has(1);
  @$pb.TagNumber(2)
  void clearStoreId() => $_clearField(2);

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

class FrameToMarkingDataResposne extends $pb.GeneratedMessage {
  factory FrameToMarkingDataResposne({
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
  FrameToMarkingDataResposne._() : super();
  factory FrameToMarkingDataResposne.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FrameToMarkingDataResposne.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FrameToMarkingDataResposne', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FrameToMarkingDataResposne clone() => FrameToMarkingDataResposne()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FrameToMarkingDataResposne copyWith(void Function(FrameToMarkingDataResposne) updates) => super.copyWith((message) => updates(message as FrameToMarkingDataResposne)) as FrameToMarkingDataResposne;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FrameToMarkingDataResposne create() => FrameToMarkingDataResposne._();
  FrameToMarkingDataResposne createEmptyInstance() => create();
  static $pb.PbList<FrameToMarkingDataResposne> createRepeated() => $pb.PbList<FrameToMarkingDataResposne>();
  @$core.pragma('dart2js:noInline')
  static FrameToMarkingDataResposne getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FrameToMarkingDataResposne>(create);
  static FrameToMarkingDataResposne? _defaultInstance;

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
