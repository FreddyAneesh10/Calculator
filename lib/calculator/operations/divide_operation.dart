import 'operation.dart';

/// LSP Fix: execute() must always honour the Operation contract and return
/// a double. Instead of throwing (which breaks callers that trust the
/// abstraction), we return double.infinity — identical to Dart's own a/0
/// behaviour and IEEE-754 compliant. ResultFormatter handles the display.
class DivideOperation implements Operation {
  @override
  double execute(double a, double b) {
    if (b == 0) return double.infinity;
    return a / b;
  }

  @override
  String formatEquation(String a, String b) {
    return '$a ÷ $b =';
  }

  @override
  String formatOngoingEquation(String a) {
    return '$a ÷';
  }
}