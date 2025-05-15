//
//  Generated code. Do not modify.
//  source: menu.proto
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

class Option extends $pb.GeneratedMessage {
  factory Option({
    $core.String? type,
    $core.Iterable<$core.String>? choices,
    $core.Iterable<$core.int>? optionPrice,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (choices != null) {
      $result.choices.addAll(choices);
    }
    if (optionPrice != null) {
      $result.optionPrice.addAll(optionPrice);
    }
    return $result;
  }
  Option._() : super();
  factory Option.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Option.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Option', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..pPS(2, _omitFieldNames ? '' : 'choices')
    ..p<$core.int>(3, _omitFieldNames ? '' : 'optionPrice', $pb.PbFieldType.K3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Option clone() => Option()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Option copyWith(void Function(Option) updates) => super.copyWith((message) => updates(message as Option)) as Option;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Option create() => Option._();
  Option createEmptyInstance() => create();
  static $pb.PbList<Option> createRepeated() => $pb.PbList<Option>();
  @$core.pragma('dart2js:noInline')
  static Option getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Option>(create);
  static Option? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get choices => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get optionPrice => $_getList(2);
}

class ViewMenu extends $pb.GeneratedMessage {
  factory ViewMenu({
    $core.String? category,
    $core.String? name,
    $core.int? menuPrice,
    $core.String? image,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    if (name != null) {
      $result.name = name;
    }
    if (menuPrice != null) {
      $result.menuPrice = menuPrice;
    }
    if (image != null) {
      $result.image = image;
    }
    return $result;
  }
  ViewMenu._() : super();
  factory ViewMenu.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ViewMenu.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ViewMenu', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'menuPrice', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'image')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ViewMenu clone() => ViewMenu()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ViewMenu copyWith(void Function(ViewMenu) updates) => super.copyWith((message) => updates(message as ViewMenu)) as ViewMenu;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ViewMenu create() => ViewMenu._();
  ViewMenu createEmptyInstance() => create();
  static $pb.PbList<ViewMenu> createRepeated() => $pb.PbList<ViewMenu>();
  @$core.pragma('dart2js:noInline')
  static ViewMenu getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ViewMenu>(create);
  static ViewMenu? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get menuPrice => $_getIZ(2);
  @$pb.TagNumber(3)
  set menuPrice($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMenuPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearMenuPrice() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get image => $_getSZ(3);
  @$pb.TagNumber(4)
  set image($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearImage() => $_clearField(4);
}

class ViewMenuDetail extends $pb.GeneratedMessage {
  factory ViewMenuDetail({
    $core.String? category,
    $core.String? name,
    $core.int? menuPrice,
    $core.String? image,
    $core.Iterable<$core.String>? signLanguageUrls,
    $core.Iterable<Option>? options,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    if (name != null) {
      $result.name = name;
    }
    if (menuPrice != null) {
      $result.menuPrice = menuPrice;
    }
    if (image != null) {
      $result.image = image;
    }
    if (signLanguageUrls != null) {
      $result.signLanguageUrls.addAll(signLanguageUrls);
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    return $result;
  }
  ViewMenuDetail._() : super();
  factory ViewMenuDetail.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ViewMenuDetail.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ViewMenuDetail', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'menuPrice', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'image')
    ..pPS(5, _omitFieldNames ? '' : 'signLanguageUrls')
    ..pc<Option>(6, _omitFieldNames ? '' : 'options', $pb.PbFieldType.PM, subBuilder: Option.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ViewMenuDetail clone() => ViewMenuDetail()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ViewMenuDetail copyWith(void Function(ViewMenuDetail) updates) => super.copyWith((message) => updates(message as ViewMenuDetail)) as ViewMenuDetail;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ViewMenuDetail create() => ViewMenuDetail._();
  ViewMenuDetail createEmptyInstance() => create();
  static $pb.PbList<ViewMenuDetail> createRepeated() => $pb.PbList<ViewMenuDetail>();
  @$core.pragma('dart2js:noInline')
  static ViewMenuDetail getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ViewMenuDetail>(create);
  static ViewMenuDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get menuPrice => $_getIZ(2);
  @$pb.TagNumber(3)
  set menuPrice($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMenuPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearMenuPrice() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get image => $_getSZ(3);
  @$pb.TagNumber(4)
  set image($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearImage() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get signLanguageUrls => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<Option> get options => $_getList(5);
}

class CreateMenuRequest extends $pb.GeneratedMessage {
  factory CreateMenuRequest({
    $core.String? storeCode,
    $core.String? category,
    $core.String? name,
    $core.int? menuPrice,
    $core.Iterable<Option>? options,
    $core.String? description,
    $core.String? signLanguageDescription,
    $core.Iterable<$core.String>? signLanguageUrls,
    $core.String? image,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (category != null) {
      $result.category = category;
    }
    if (name != null) {
      $result.name = name;
    }
    if (menuPrice != null) {
      $result.menuPrice = menuPrice;
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    if (description != null) {
      $result.description = description;
    }
    if (signLanguageDescription != null) {
      $result.signLanguageDescription = signLanguageDescription;
    }
    if (signLanguageUrls != null) {
      $result.signLanguageUrls.addAll(signLanguageUrls);
    }
    if (image != null) {
      $result.image = image;
    }
    return $result;
  }
  CreateMenuRequest._() : super();
  factory CreateMenuRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateMenuRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateMenuRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'menuPrice', $pb.PbFieldType.O3)
    ..pc<Option>(5, _omitFieldNames ? '' : 'options', $pb.PbFieldType.PM, subBuilder: Option.create)
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'signLanguageDescription')
    ..pPS(8, _omitFieldNames ? '' : 'signLanguageUrls')
    ..aOS(9, _omitFieldNames ? '' : 'image')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateMenuRequest clone() => CreateMenuRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateMenuRequest copyWith(void Function(CreateMenuRequest) updates) => super.copyWith((message) => updates(message as CreateMenuRequest)) as CreateMenuRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateMenuRequest create() => CreateMenuRequest._();
  CreateMenuRequest createEmptyInstance() => create();
  static $pb.PbList<CreateMenuRequest> createRepeated() => $pb.PbList<CreateMenuRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateMenuRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateMenuRequest>(create);
  static CreateMenuRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get menuPrice => $_getIZ(3);
  @$pb.TagNumber(4)
  set menuPrice($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMenuPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearMenuPrice() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<Option> get options => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get signLanguageDescription => $_getSZ(6);
  @$pb.TagNumber(7)
  set signLanguageDescription($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSignLanguageDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearSignLanguageDescription() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get signLanguageUrls => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get image => $_getSZ(8);
  @$pb.TagNumber(9)
  set image($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasImage() => $_has(8);
  @$pb.TagNumber(9)
  void clearImage() => $_clearField(9);
}

class GetCategoryListRequest extends $pb.GeneratedMessage {
  factory GetCategoryListRequest({
    $core.String? storeCode,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    return $result;
  }
  GetCategoryListRequest._() : super();
  factory GetCategoryListRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCategoryListRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCategoryListRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCategoryListRequest clone() => GetCategoryListRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCategoryListRequest copyWith(void Function(GetCategoryListRequest) updates) => super.copyWith((message) => updates(message as GetCategoryListRequest)) as GetCategoryListRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCategoryListRequest create() => GetCategoryListRequest._();
  GetCategoryListRequest createEmptyInstance() => create();
  static $pb.PbList<GetCategoryListRequest> createRepeated() => $pb.PbList<GetCategoryListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCategoryListRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCategoryListRequest>(create);
  static GetCategoryListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);
}

class GetMenuListRequest extends $pb.GeneratedMessage {
  factory GetMenuListRequest({
    $core.String? storeCode,
    $core.String? category,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  GetMenuListRequest._() : super();
  factory GetMenuListRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMenuListRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMenuListRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMenuListRequest clone() => GetMenuListRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMenuListRequest copyWith(void Function(GetMenuListRequest) updates) => super.copyWith((message) => updates(message as GetMenuListRequest)) as GetMenuListRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMenuListRequest create() => GetMenuListRequest._();
  GetMenuListRequest createEmptyInstance() => create();
  static $pb.PbList<GetMenuListRequest> createRepeated() => $pb.PbList<GetMenuListRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMenuListRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMenuListRequest>(create);
  static GetMenuListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);
}

class GetMenuDetailRequest extends $pb.GeneratedMessage {
  factory GetMenuDetailRequest({
    $core.String? storeCode,
    $core.String? category,
    $core.String? name,
  }) {
    final $result = create();
    if (storeCode != null) {
      $result.storeCode = storeCode;
    }
    if (category != null) {
      $result.category = category;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetMenuDetailRequest._() : super();
  factory GetMenuDetailRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMenuDetailRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMenuDetailRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storeCode')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMenuDetailRequest clone() => GetMenuDetailRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMenuDetailRequest copyWith(void Function(GetMenuDetailRequest) updates) => super.copyWith((message) => updates(message as GetMenuDetailRequest)) as GetMenuDetailRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMenuDetailRequest create() => GetMenuDetailRequest._();
  GetMenuDetailRequest createEmptyInstance() => create();
  static $pb.PbList<GetMenuDetailRequest> createRepeated() => $pb.PbList<GetMenuDetailRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMenuDetailRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMenuDetailRequest>(create);
  static GetMenuDetailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set storeCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStoreCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearStoreCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);
}

class CreateMenuResponse extends $pb.GeneratedMessage {
  factory CreateMenuResponse({
    $core.bool? success,
    $9.EError? error,
    ViewMenu? menu,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (menu != null) {
      $result.menu = menu;
    }
    return $result;
  }
  CreateMenuResponse._() : super();
  factory CreateMenuResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateMenuResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateMenuResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..aOM<ViewMenu>(3, _omitFieldNames ? '' : 'menu', subBuilder: ViewMenu.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateMenuResponse clone() => CreateMenuResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateMenuResponse copyWith(void Function(CreateMenuResponse) updates) => super.copyWith((message) => updates(message as CreateMenuResponse)) as CreateMenuResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateMenuResponse create() => CreateMenuResponse._();
  CreateMenuResponse createEmptyInstance() => create();
  static $pb.PbList<CreateMenuResponse> createRepeated() => $pb.PbList<CreateMenuResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateMenuResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateMenuResponse>(create);
  static CreateMenuResponse? _defaultInstance;

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
  ViewMenu get menu => $_getN(2);
  @$pb.TagNumber(3)
  set menu(ViewMenu v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMenu() => $_has(2);
  @$pb.TagNumber(3)
  void clearMenu() => $_clearField(3);
  @$pb.TagNumber(3)
  ViewMenu ensureMenu() => $_ensure(2);
}

class GetCategoryListResponse extends $pb.GeneratedMessage {
  factory GetCategoryListResponse({
    $core.bool? success,
    $9.EError? error,
    $core.Iterable<$core.String>? categories,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (categories != null) {
      $result.categories.addAll(categories);
    }
    return $result;
  }
  GetCategoryListResponse._() : super();
  factory GetCategoryListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCategoryListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCategoryListResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..pPS(3, _omitFieldNames ? '' : 'categories')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCategoryListResponse clone() => GetCategoryListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCategoryListResponse copyWith(void Function(GetCategoryListResponse) updates) => super.copyWith((message) => updates(message as GetCategoryListResponse)) as GetCategoryListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCategoryListResponse create() => GetCategoryListResponse._();
  GetCategoryListResponse createEmptyInstance() => create();
  static $pb.PbList<GetCategoryListResponse> createRepeated() => $pb.PbList<GetCategoryListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCategoryListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCategoryListResponse>(create);
  static GetCategoryListResponse? _defaultInstance;

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
  $pb.PbList<$core.String> get categories => $_getList(2);
}

class GetMenuListResponse extends $pb.GeneratedMessage {
  factory GetMenuListResponse({
    $core.bool? success,
    $9.EError? error,
    $core.Iterable<ViewMenu>? menus,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (menus != null) {
      $result.menus.addAll(menus);
    }
    return $result;
  }
  GetMenuListResponse._() : super();
  factory GetMenuListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMenuListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMenuListResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..pc<ViewMenu>(3, _omitFieldNames ? '' : 'menus', $pb.PbFieldType.PM, subBuilder: ViewMenu.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMenuListResponse clone() => GetMenuListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMenuListResponse copyWith(void Function(GetMenuListResponse) updates) => super.copyWith((message) => updates(message as GetMenuListResponse)) as GetMenuListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMenuListResponse create() => GetMenuListResponse._();
  GetMenuListResponse createEmptyInstance() => create();
  static $pb.PbList<GetMenuListResponse> createRepeated() => $pb.PbList<GetMenuListResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMenuListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMenuListResponse>(create);
  static GetMenuListResponse? _defaultInstance;

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
  $pb.PbList<ViewMenu> get menus => $_getList(2);
}

class GetMenuDetailResponse extends $pb.GeneratedMessage {
  factory GetMenuDetailResponse({
    $core.bool? success,
    $9.EError? error,
    ViewMenuDetail? menu,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (error != null) {
      $result.error = error;
    }
    if (menu != null) {
      $result.menu = menu;
    }
    return $result;
  }
  GetMenuDetailResponse._() : super();
  factory GetMenuDetailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMenuDetailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMenuDetailResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<$9.EError>(2, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $9.EError.EE_UNSPECIFIED, valueOf: $9.EError.valueOf, enumValues: $9.EError.values)
    ..aOM<ViewMenuDetail>(3, _omitFieldNames ? '' : 'menu', subBuilder: ViewMenuDetail.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMenuDetailResponse clone() => GetMenuDetailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMenuDetailResponse copyWith(void Function(GetMenuDetailResponse) updates) => super.copyWith((message) => updates(message as GetMenuDetailResponse)) as GetMenuDetailResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMenuDetailResponse create() => GetMenuDetailResponse._();
  GetMenuDetailResponse createEmptyInstance() => create();
  static $pb.PbList<GetMenuDetailResponse> createRepeated() => $pb.PbList<GetMenuDetailResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMenuDetailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMenuDetailResponse>(create);
  static GetMenuDetailResponse? _defaultInstance;

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
  ViewMenuDetail get menu => $_getN(2);
  @$pb.TagNumber(3)
  set menu(ViewMenuDetail v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMenu() => $_has(2);
  @$pb.TagNumber(3)
  void clearMenu() => $_clearField(3);
  @$pb.TagNumber(3)
  ViewMenuDetail ensureMenu() => $_ensure(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
