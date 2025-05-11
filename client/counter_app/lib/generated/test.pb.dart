//
//  Generated code. Do not modify.
//  source: test.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TestStruct extends $pb.GeneratedMessage {
  factory TestStruct({
    $core.String? name,
    $core.int? age,
    $core.bool? isStudent,
    $core.Iterable<$core.String>? friends,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (age != null) {
      $result.age = age;
    }
    if (isStudent != null) {
      $result.isStudent = isStudent;
    }
    if (friends != null) {
      $result.friends.addAll(friends);
    }
    return $result;
  }
  TestStruct._() : super();
  factory TestStruct.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TestStruct.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TestStruct', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'age', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'isStudent')
    ..pPS(4, _omitFieldNames ? '' : 'friends')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TestStruct clone() => TestStruct()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TestStruct copyWith(void Function(TestStruct) updates) => super.copyWith((message) => updates(message as TestStruct)) as TestStruct;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestStruct create() => TestStruct._();
  TestStruct createEmptyInstance() => create();
  static $pb.PbList<TestStruct> createRepeated() => $pb.PbList<TestStruct>();
  @$core.pragma('dart2js:noInline')
  static TestStruct getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestStruct>(create);
  static TestStruct? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get age => $_getIZ(1);
  @$pb.TagNumber(2)
  set age($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAge() => $_has(1);
  @$pb.TagNumber(2)
  void clearAge() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isStudent => $_getBF(2);
  @$pb.TagNumber(3)
  set isStudent($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsStudent() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsStudent() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get friends => $_getList(3);
}

class AddTestStructRequest extends $pb.GeneratedMessage {
  factory AddTestStructRequest({
    TestStruct? testStruct,
  }) {
    final $result = create();
    if (testStruct != null) {
      $result.testStruct = testStruct;
    }
    return $result;
  }
  AddTestStructRequest._() : super();
  factory AddTestStructRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddTestStructRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddTestStructRequest', createEmptyInstance: create)
    ..aOM<TestStruct>(1, _omitFieldNames ? '' : 'testStruct', subBuilder: TestStruct.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddTestStructRequest clone() => AddTestStructRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddTestStructRequest copyWith(void Function(AddTestStructRequest) updates) => super.copyWith((message) => updates(message as AddTestStructRequest)) as AddTestStructRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddTestStructRequest create() => AddTestStructRequest._();
  AddTestStructRequest createEmptyInstance() => create();
  static $pb.PbList<AddTestStructRequest> createRepeated() => $pb.PbList<AddTestStructRequest>();
  @$core.pragma('dart2js:noInline')
  static AddTestStructRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddTestStructRequest>(create);
  static AddTestStructRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TestStruct get testStruct => $_getN(0);
  @$pb.TagNumber(1)
  set testStruct(TestStruct v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTestStruct() => $_has(0);
  @$pb.TagNumber(1)
  void clearTestStruct() => $_clearField(1);
  @$pb.TagNumber(1)
  TestStruct ensureTestStruct() => $_ensure(0);
}

class AddTestStructResponse extends $pb.GeneratedMessage {
  factory AddTestStructResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  AddTestStructResponse._() : super();
  factory AddTestStructResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddTestStructResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddTestStructResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddTestStructResponse clone() => AddTestStructResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddTestStructResponse copyWith(void Function(AddTestStructResponse) updates) => super.copyWith((message) => updates(message as AddTestStructResponse)) as AddTestStructResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddTestStructResponse create() => AddTestStructResponse._();
  AddTestStructResponse createEmptyInstance() => create();
  static $pb.PbList<AddTestStructResponse> createRepeated() => $pb.PbList<AddTestStructResponse>();
  @$core.pragma('dart2js:noInline')
  static AddTestStructResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddTestStructResponse>(create);
  static AddTestStructResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
