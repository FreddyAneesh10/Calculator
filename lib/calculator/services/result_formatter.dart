import 'i_result_formatter.dart';

/// SRP Fix: Each private method has exactly one reason to change.
///   - [_trimDecimal]: handles number precision (trim ".0" suffix).
///   - [_applyLocale]: handles locale display (dot → comma separator).
///
/// DIP Fix: Implements [IResultFormatter] so the Interactor depends on
/// the abstraction, not this concrete class.
class ResultFormatter implements IResultFormatter {

  @override
  String format(double result) {
    // LSP/DivideOperation support: handle special IEEE-754 values.
    if (result.isInfinite) return result > 0 ? '∞' : '-∞';
    if (result.isNaN) return 'Error';

    final trimmed = _trimDecimal(result.toString());
    return _applyLocale(trimmed);
  }

  /// Responsibility 1: Remove redundant ".0" from whole-number results.
  String _trimDecimal(String value) {
    if (value.endsWith('.0')) {
      return value.substring(0, value.length - 2);
    }
    return value;
  }

  /// Responsibility 2: Apply locale decimal separator (dot → comma).
  String _applyLocale(String value) {
    return value.replaceAll('.', ',');
  }

}