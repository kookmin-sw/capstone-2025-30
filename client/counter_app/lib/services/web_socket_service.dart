import 'dart:io';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  WebSocket? _ws;
  bool isConnected = false;
  final List<String> signUrls = [];
  final Logger logger = Logger();

  void Function()? onInquiryRequestReceived;

  final String wsUrl =
      '${dotenv.env['WS_URL']}?store_code=5fjVwE8z&client_type=counter_app&api-key=${dotenv.env['WS_API_KEY']}';

  Future<void> connect() async {
    if (_ws != null && _ws!.readyState == WebSocket.open) {
      logger.i('이미 연결됨');
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
        },
        onError: (error) {
          logger.e('websocket 오류: $error');
          isConnected = false;
        },
      );
    } catch (e) {
      logger.e('websocket 연결 실패: $e');
      isConnected = false;
    }
  }

  void disconnect() {
    if (_ws != null) {
      _ws!.close();
      logger.i('websocket 연결 종료');
      isConnected = false;
    }
  }

  void _handleMessage(String rawData) {
    try {
      final Map<String, dynamic> json = jsonDecode(rawData);
      final String type = json['type'];

      if (type == 'signMessage') {
        final data = json['data'];

        final String? title = data['title'];
        if (title != 'inquiryRequest') {
          onInquiryRequestReceived!();
          return;
        }

        final List<dynamic> urls = data['sign_urls'];
        signUrls.clear();
        signUrls.addAll(urls.cast<String>());

        logger.i('signMessage 수신 (inquiryRequest):');
        for (var url in signUrls) {
          logger.i(url);
        }

        logger.i('signmessage 수신:');
        for (var url in signUrls) {
          logger.i(url);
        }
      } else {
        logger.w('signMessage가 아님: $type');
      }
    } catch (e) {
      logger.e('메시지 파싱 실패: $e');
    }
  }

  List<String> getSignUrls() => signUrls;
}
