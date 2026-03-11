import 'unary_operation.dart';

class NegateOperation implements UnaryOperation {
  @override
  double execute(double value) {
    return value * -1.0;
  }

  @override
  String formatEquation(String input) {
    return '-($input) =';
  }
}
