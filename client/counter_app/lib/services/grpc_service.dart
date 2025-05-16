import 'package:grpc/grpc.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../generated/middleware.pbgrpc.dart';
import '../generated/service.pbgrpc.dart';
import '../generated/inquiry.pb.dart';

class GrpcService {
  ClientChannel? _middlewareChannel;
  ClientChannel? _apiChannel;

  ChangeMiddlwareClient? _middlewareClient;
  APIServiceClient? _apiClient;

  final Logger logger = Logger(level: Level.verbose);

  Future<void> connect() async {
    _middlewareChannel = ClientChannel(
      'python.signorder.kr', // '13.125.250.244',
      port: 443, // 8088
      options: const ChannelOptions(
        credentials: ChannelCredentials.secure(),
      ), // insecure()
    );

    _apiChannel = ClientChannel(
      'go.signorder.kr', // '3.34.190.174',
      port: 443, // 8080
      options: const ChannelOptions(credentials: ChannelCredentials.secure()),
    );

    _middlewareClient = ChangeMiddlwareClient(_middlewareChannel!);
    _apiClient = APIServiceClient(_apiChannel!);
  }

  // O 버튼 클릭 시 (정확히는 카메라 화면에서 사용)
  Future<bool> sendFrames(
    List<List<int>> frameBuffer, {
    required String inquiryType,
    required int num,
  }) async {
    if (_middlewareClient == null) {
      throw Exception('grpc 클라이언트가 연결되지 않음');
    }

    try {
      final response = await _middlewareClient!.frameToMarkingData(
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
        "프레임 서버 응답: ${response.success}, 프레임 에러: ${response.hasError() ? response.error : '없음'}",
      );
      return response.success;
    } catch (e, st) {
      logger.e("프레임 전송 중 오류: $e, $st");
      return false;
    }
  }

  // X 버튼 클릭 시
  Future<bool> sendFastInquiryRespIsNo({
    required String title,
    required int num,
  }) async {
    if (_apiClient == null) {
      throw Exception('gRPC 클라이언트가 초기화되지 않았습니다.');
    }

    try {
      final request =
          FastInquiryRespIsNoRequest()
            ..storeCode = '5fjVwE8z'
            ..title = title
            ..num = num;

      final callOptions = CallOptions(
        metadata: {'api-key': '${dotenv.env['API_KEY']}'},
      );

      final response = await _apiClient!.fastInquiryRespIsNo(
        request,
        options: callOptions,
      );
      logger.i("X 버튼 응답: ${response.success}");
      return response.success;
    } catch (e) {
      logger.e("X 버튼 호출 오류: $e");
      return false;
    }
  }

  Future<void> shutdown() async {
    await _middlewareChannel?.shutdown();
    await _apiChannel?.shutdown();
    _middlewareClient = null;
    _apiClient = null;
  }
}
