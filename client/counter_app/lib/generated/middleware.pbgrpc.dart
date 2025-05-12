//
//  Generated code. Do not modify.
//  source: middleware.proto
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

import 'middleware.pb.dart' as $1;

export 'middleware.pb.dart';

@$pb.GrpcServiceName('ChangeMiddlware')
class ChangeMiddlwareClient extends $grpc.Client {
  static final _$frameToMarkingData = $grpc.ClientMethod<$1.FrameToMarkingDataRequest, $1.FrameToMarkingDataResposne>(
      '/ChangeMiddlware/FrameToMarkingData',
      ($1.FrameToMarkingDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.FrameToMarkingDataResposne.fromBuffer(value));

  ChangeMiddlwareClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.FrameToMarkingDataResposne> frameToMarkingData($async.Stream<$1.FrameToMarkingDataRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$frameToMarkingData, request, options: options).single;
  }
}

@$pb.GrpcServiceName('ChangeMiddlware')
abstract class ChangeMiddlwareServiceBase extends $grpc.Service {
  $core.String get $name => 'ChangeMiddlware';

  ChangeMiddlwareServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.FrameToMarkingDataRequest, $1.FrameToMarkingDataResposne>(
        'FrameToMarkingData',
        frameToMarkingData,
        true,
        false,
        ($core.List<$core.int> value) => $1.FrameToMarkingDataRequest.fromBuffer(value),
        ($1.FrameToMarkingDataResposne value) => value.writeToBuffer()));
  }

  $async.Future<$1.FrameToMarkingDataResposne> frameToMarkingData($grpc.ServiceCall call, $async.Stream<$1.FrameToMarkingDataRequest> request);
}
