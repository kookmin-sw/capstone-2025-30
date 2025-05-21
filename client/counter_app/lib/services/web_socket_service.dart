import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();
  final StreamController<List<String>> _signUrlsController =
      StreamController<List<String>>.broadcast();

  Stream<List<String>> get signUrlsStream => _signUrlsController.stream;
  WebSocket? _ws;
  bool isConnected = false;
  bool isReconnecting = false;
  final List<String> signUrls = [];
  final Logger logger = Logger();

  void Function(int number)? onInquiryRequestReceived;

  final String wsUrl =
      '${dotenv.env['WS_URL']}?store_code=5fjVwE8z&client_type=counter_app&api-key=${dotenv.env['WS_API_KEY']}';

  Future<void> connect() async {
    if (_ws != null && _ws!.readyState == WebSocket.open && isConnected) {
      logger.i('websocket 이미 연결됨');
      return;
    }

    try {
      _ws = await WebSocket.connect(wsUrl);
      isConnected = true;
      logger.i('websocket 연결됨');

      _ws!.listen(
        (data) {
          logger.i('websocket 메시지 수신: $data');
          _handleMessage(data);
        },
        onDone: () {
          logger.i('websocket 연결 종료');
          isConnected = false;
          _reconnect();
        },
        onError: (error) {
          logger.e('websocket 오류: $error');
          isConnected = false;
          _reconnect();
        },
      );
    } catch (e) {
      logger.e('websocket 연결 실패: $e');
      isConnected = false;
      _reconnect();
    }
  }

  void disconnect() {
    if (_ws != null) {
      _ws!.close();
      logger.i('websocket 연결 종료');
      isConnected = false;
    }
  }

  void _reconnect() {
    if (isReconnecting) return;
    isReconnecting = true;

    const retryDelay = Duration(seconds: 2);
    logger.w('websocket 재연결 시도 중...');

    Future.delayed(retryDelay, () async {
      if (!isConnected) {
        await connect();
      }
      isReconnecting = false;
    });
  }

  void _handleMessage(String rawData) {
    try {
      final Map<String, dynamic> json = jsonDecode(rawData);
      final String? type = json['type'] ?? json['title'];
      final dynamic data = json['data'] ?? json;

      logger.i('websocket 수신 메시지: $type');

      final int? number = data['num'] ?? data['number'];

      if (type == 'signMessage') {
        final urlsRaw = data['sign_urls'];
        final title = data['title'];

        if (urlsRaw is List && urlsRaw.isNotEmpty) {
          signUrls
            ..clear()
            ..addAll(urlsRaw.cast<String>());

          _signUrlsController.add(signUrls);
          logger.i('수어 영상 URL 로딩 완료:\n${signUrls.join('\n')}');
        }

        if ((urlsRaw == null || urlsRaw.isEmpty) &&
            title == 'order' &&
            number != null) {
          onInquiryRequestReceived?.call(number);
        }
      } else if (type == 'orderMessage' && number != null) {
        logger.i('orderMessage 수신');
        onInquiryRequestReceived?.call(number);
      } else {
        logger.w('처리되지 않은 메시지 타입: $type');
      }
    } catch (e, st) {
      logger.e('메시지 파싱 실패: $e\n$st');
    }
  }

  List<String> getSignUrls() => signUrls;
}
