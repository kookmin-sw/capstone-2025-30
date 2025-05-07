import 'package:counter_app/screens/answer_screen.dart';
import 'package:counter_app/screens/question_screen.dart';
import 'package:flutter/material.dart';
import 'styles/custom_styles.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
