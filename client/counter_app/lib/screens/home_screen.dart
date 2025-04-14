import 'package:flutter/material.dart';
import '../styles/custom_styles.dart';

import 'package:counter_app/components/header.dart';
import 'question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Header(
            centerIcon: Text(
              "🏠",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) {
              setState(() => _isPressed = false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuestionScreen()),
              );
            },
            onTapCancel: () => setState(() => _isPressed = false),
            child: Container(
              width: screenWidth * 0.7,
              height: screenWidth * 0.7 * (376 / 232),
              decoration: BoxDecoration(
                color:
                    _isPressed
                        ? CustomStyles.primaryBlue
                        : CustomStyles.primaryGray,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('💬', style: const TextStyle(fontSize: 80)),
                  const SizedBox(height: 16),
                  Text(
                    '문의하기',
                    style: CustomStyles.fontHead28.copyWith(
                      color:
                          _isPressed
                              ? CustomStyles.primaryWhite
                              : CustomStyles.primaryBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
