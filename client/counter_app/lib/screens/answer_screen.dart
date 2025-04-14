import 'package:flutter/material.dart';
import 'package:counter_app/components/header.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(
            centerIcon: Text(
              "💬",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
