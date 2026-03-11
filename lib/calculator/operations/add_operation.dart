import 'operation.dart';

class AddOperation implements Operation {
  @override
  double execute(double a, double b) {
    return a + b;
  }
}