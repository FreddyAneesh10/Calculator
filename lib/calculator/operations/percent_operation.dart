import 'unary_operation.dart';

class PercentOperation implements UnaryOperation {
  @override
  double execute(double value) {
    return value / 100.0;
  }

  @override
  String formatEquation(String input) {
    return '$input % =';
  }
}
