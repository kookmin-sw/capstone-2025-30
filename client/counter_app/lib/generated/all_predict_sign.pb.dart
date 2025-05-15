//
//  Generated code. Do not modify.
//  source: all_predict_sign.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FrameSequenceInput extends $pb.GeneratedMessage {
  factory FrameSequenceInput({
    $core.Iterable<$core.double>? frames,
    $core.String? storeId,
    $core.int? fps,
    $core.int? videoLength,
  }) {
    final $result = create();
    if (frames != null) {
      $result.frames.addAll(frames);
    }
    if (storeId != null) {
      $result.storeId = storeId;
    }
    if (fps != null) {
      $result.fps = fps;
    }
    if (videoLength != null) {
      $result.videoLength = videoLength;
    }
    return $result;
  }
  FrameSequenceInput._() : super();
  factory FrameSequenceInput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FrameSequenceInput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FrameSequenceInput', package: const $pb.PackageName(_omitMessageNames ? '' : 'predict'), createEmptyInstance: create)
    ..p<$core.double>(1, _omitFieldNames ? '' : 'frames', $pb.PbFieldType.KF)
    ..aOS(2, _omitFieldNames ? '' : 'storeId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'fps', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'videoLength', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FrameSequenceInput clone() => FrameSequenceInput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FrameSequenceInput copyWith(void Function(FrameSequenceInput) updates) => super.copyWith((message) => updates(message as FrameSequenceInput)) as FrameSequenceInput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FrameSequenceInput create() => FrameSequenceInput._();
  FrameSequenceInput createEmptyInstance() => create();
  static $pb.PbList<FrameSequenceInput> createRepeated() => $pb.PbList<FrameSequenceInput>();
  @$core.pragma('dart2js:noInline')
  static FrameSequenceInput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FrameSequenceInput>(create);
  static FrameSequenceInput? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.double> get frames => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get storeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set storeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStoreId() => $_has(1);
  @$pb.TagNumber(2)
  void clearStoreId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get fps => $_getIZ(2);
  @$pb.TagNumber(3)
  set fps($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFps() => $_has(2);
  @$pb.TagNumber(3)
  void clearFps() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get videoLength => $_getIZ(3);
  @$pb.TagNumber(4)
  set videoLength($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVideoLength() => $_has(3);
  @$pb.TagNumber(4)
  void clearVideoLength() => $_clearField(4);
}

class PredictResult extends $pb.GeneratedMessage {
  factory PredictResult({
    $core.String? storeId,
    $core.String? predictedSentence,
    $core.double? confidence,
  }) {
    final $result = create();
    if (storeId != null) {
      $result.storeId = storeId;
    }
    if (predictedSentence != null) {
      $result.predictedSentence = predictedSentence;
    }
    if (confidence != null) {
      $result.confidence = confidence;
    }
    return $result;
  }
  PredictResult._() : super();
  factory PredictResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PredictResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PredictResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'predict'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeId')
    ..aOS(2, _omitFieldNames ? '' : 'predictedSentence')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PredictResult clone() => PredictResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PredictResult copyWith(void Function(PredictResult) updates) => super.copyWith((message) => updates(message as PredictResult)) as PredictResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PredictResult create() => PredictResult._();
  PredictResult createEmptyInstance() => create();
  static $pb.PbList<PredictResult> createRepeated() => $pb.PbList<PredictResult>();
  @$core.pragma('dart2js:noInline')
  static PredictResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PredictResult>(create);
  static PredictResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get predictedSentence => $_getSZ(1);
  @$pb.TagNumber(2)
  set predictedSentence($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPredictedSentence() => $_has(1);
  @$pb.TagNumber(2)
  void clearPredictedSentence() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get confidence => $_getN(2);
  @$pb.TagNumber(3)
  set confidence($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfidence() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidence() => $_clearField(3);
}

class KoreanInput extends $pb.GeneratedMessage {
  factory KoreanInput({
    $core.String? message,
    $core.String? storeId,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    if (storeId != null) {
      $result.storeId = storeId;
    }
    return $result;
  }
  KoreanInput._() : super();
  factory KoreanInput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KoreanInput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'KoreanInput', package: const $pb.PackageName(_omitMessageNames ? '' : 'predict'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOS(2, _omitFieldNames ? '' : 'storeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KoreanInput clone() => KoreanInput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KoreanInput copyWith(void Function(KoreanInput) updates) => super.copyWith((message) => updates(message as KoreanInput)) as KoreanInput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KoreanInput create() => KoreanInput._();
  KoreanInput createEmptyInstance() => create();
  static $pb.PbList<KoreanInput> createRepeated() => $pb.PbList<KoreanInput>();
  @$core.pragma('dart2js:noInline')
  static KoreanInput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KoreanInput>(create);
  static KoreanInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get storeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set storeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStoreId() => $_has(1);
  @$pb.TagNumber(2)
  void clearStoreId() => $_clearField(2);
}

class SignUrlResult extends $pb.GeneratedMessage {
  factory SignUrlResult({
    $core.String? storeId,
    $core.Iterable<$core.String>? urls,
  }) {
    final $result = create();
    if (storeId != null) {
      $result.storeId = storeId;
    }
    if (urls != null) {
      $result.urls.addAll(urls);
    }
    return $result;
  }
  SignUrlResult._() : super();
  factory SignUrlResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignUrlResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignUrlResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'predict'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeId')
    ..pPS(2, _omitFieldNames ? '' : 'urls')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignUrlResult clone() => SignUrlResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignUrlResult copyWith(void Function(SignUrlResult) updates) => super.copyWith((message) => updates(message as SignUrlResult)) as SignUrlResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignUrlResult create() => SignUrlResult._();
  SignUrlResult createEmptyInstance() => create();
  static $pb.PbList<SignUrlResult> createRepeated() => $pb.PbList<SignUrlResult>();
  @$core.pragma('dart2js:noInline')
  static SignUrlResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUrlResult>(create);
  static SignUrlResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get urls => $_getList(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
