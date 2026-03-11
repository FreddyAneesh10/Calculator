import 'operation.dart';

class MultiplyOperation implements Operation {
  @override
  double execute(double a, double b) {
    return a * b;
  }

  @override
  String formatEquation(String a, String b) {
    return '$a × $b =';
  }

  @override
  String formatOngoingEquation(String a) {
    return '$a ×';
  }
}