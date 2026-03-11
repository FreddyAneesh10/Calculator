import 'operation.dart';

class DivideOperation implements Operation {
  @override
  double execute(double a, double b) {
    if (b == 0) {
      throw Exception("Division by zero");
    }
    return a / b;
  }
}