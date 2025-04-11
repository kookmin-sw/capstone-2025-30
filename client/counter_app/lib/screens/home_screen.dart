import 'package:flutter/material.dart';
import '../styles/custom_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        '폰트 및 색상 테스트',
        style: CustomStyles.fontHead28.copyWith(
          color: CustomStyles.primaryBlue,
        ),
      ),
    );
  }
}
