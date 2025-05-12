//
//  Generated code. Do not modify.
//  source: all_predict_sign.proto
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

import 'all_predict_sign.pb.dart' as $0;

export 'all_predict_sign.pb.dart';

@$pb.GrpcServiceName('predict.SignAI')
class SignAIClient extends $grpc.Client {
  static final _$predictFromFrames = $grpc.ClientMethod<$0.FrameSequenceInput, $0.PredictResult>(
      '/predict.SignAI/PredictFromFrames',
      ($0.FrameSequenceInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PredictResult.fromBuffer(value));
  static final _$translateKoreanToSignUrls = $grpc.ClientMethod<$0.KoreanInput, $0.SignUrlResult>(
      '/predict.SignAI/TranslateKoreanToSignUrls',
      ($0.KoreanInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SignUrlResult.fromBuffer(value));

  SignAIClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.PredictResult> predictFromFrames($0.FrameSequenceInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$predictFromFrames, request, options: options);
  }

  $grpc.ResponseFuture<$0.SignUrlResult> translateKoreanToSignUrls($0.KoreanInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$translateKoreanToSignUrls, request, options: options);
  }
}

@$pb.GrpcServiceName('predict.SignAI')
abstract class SignAIServiceBase extends $grpc.Service {
  $core.String get $name => 'predict.SignAI';

  SignAIServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.FrameSequenceInput, $0.PredictResult>(
        'PredictFromFrames',
        predictFromFrames_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FrameSequenceInput.fromBuffer(value),
        ($0.PredictResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.KoreanInput, $0.SignUrlResult>(
        'TranslateKoreanToSignUrls',
        translateKoreanToSignUrls_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.KoreanInput.fromBuffer(value),
        ($0.SignUrlResult value) => value.writeToBuffer()));
  }

  $async.Future<$0.PredictResult> predictFromFrames_Pre($grpc.ServiceCall $call, $async.Future<$0.FrameSequenceInput> $request) async {
    return predictFromFrames($call, await $request);
  }

  $async.Future<$0.SignUrlResult> translateKoreanToSignUrls_Pre($grpc.ServiceCall $call, $async.Future<$0.KoreanInput> $request) async {
    return translateKoreanToSignUrls($call, await $request);
  }

  $async.Future<$0.PredictResult> predictFromFrames($grpc.ServiceCall call, $0.FrameSequenceInput request);
  $async.Future<$0.SignUrlResult> translateKoreanToSignUrls($grpc.ServiceCall call, $0.KoreanInput request);
}
