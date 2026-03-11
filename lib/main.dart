import 'package:flutter/material.dart';
import 'calculator/router/calculator_router.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter VIPER Calculator',
      debugShowCheckedModeBanner: false,
      home: CalculatorRouter.createModule(),
    );
  }
}
