import 'package:grpc/grpc.dart';
import 'package:logger/logger.dart';

import '../generated/middleware.pbgrpc.dart';

class GrpcService {
  ClientChannel? _channel;
  ChangeMiddlwareClient? _client;
  final Logger logger = Logger();

  Future<void> connect() async {
    logger.i("gprc 연결");
    _channel = ClientChannel(
      '3.34.190.174',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _client = ChangeMiddlwareClient(_channel!);
  }

  Future<bool> sendFrames(
    List<List<int>> frameBuffer, {
    required String inquiryType,
    required int num,
  }) async {
    if (_client == null) {
      throw Exception('grpc 클라이언트가 연결되지 않음');
    }

    try {
      final response = await _client!.frameToMarkingData(
        Stream.fromIterable(
          frameBuffer.map(
            (f) =>
                FrameToMarkingDataRequest()
                  ..frame.add(f)
                  ..storeId = '5fjVwE8z'
                  ..inquiryType = inquiryType
                  ..num = num,
          ),
        ),
      );

      logger.i(
        "서버 응답: ${response.success}, 에러: ${response.hasError() ? response.error : '없음'}",
      );
      return response.success;
    } catch (e) {
      logger.e("프레임 전송 중 오류: $e");
      return false;
    }
  }

  Future<void> shutdown() async {
    await _channel?.shutdown();
    _channel = null;
    _client = null;
  }
}
