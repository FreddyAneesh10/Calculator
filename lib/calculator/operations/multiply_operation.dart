import 'operation.dart';

class MultiplyOperation implements Operation {
  @override
  double execute(double a, double b) {
    return a * b;
  }
}