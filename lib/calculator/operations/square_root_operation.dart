import 'dart:math';
import 'unary_operation.dart';

class SquareRootOperation implements UnaryOperation {
  @override
  double execute(double value) {
    if (value < 0) return double.nan; // Handle negative square roots gracefully
    return sqrt(value);
  }

  @override
  String formatEquation(String input) {
    return '√($input) =';
  }
}
