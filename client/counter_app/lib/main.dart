import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'services/web_socket_service.dart';
import 'package:counter_app/screens/answer_screen.dart';
import 'package:counter_app/screens/question_screen.dart';
import 'styles/custom_styles.dart';
import 'screens/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await WebSocketService().connect();

  WebSocketService().onSignUrlsReceived = () {
    final nav = navigatorKey.currentState!;
    final isAlreadyOnAnswer =
        nav.canPop() && nav.context.widget is AnswerScreen;

    if (!isAlreadyOnAnswer) {
      nav.push(MaterialPageRoute(builder: (_) => const AnswerScreen()));
    }
  };

  WebSocketService().onInquiryRequestReceived = (int number) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => AnswerScreen(isOrder: true, number: number),
      ),
    );
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'sign-order',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CustomStyles.primaryWhite),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/answer': (context) => const AnswerScreen(),
        '/question': (context) => const QuestionScreen(),
      },
    );
  }
}
