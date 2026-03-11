import '../operations/operation.dart';
import '../services/result_formatter.dart';

class CalculatorInteractor {

  final ResultFormatter _formatter;
  final Map<String, Operation> _operations;

  CalculatorInteractor({
    required Map<String, Operation> operations,
    required ResultFormatter formatter,
  })  : _operations = operations,
        _formatter = formatter;

  String _currentInput = '0';
  String _previousInput = '';
  String _operator = '';
  String _equation = '';
  bool _shouldResetInput = false;

  String get displayValue => _currentInput;
  String get equation => _equation;

  void handleInput(String input) {

    if (input == 'C') {
      _clear();
    }
    else if (input == '=') {
      _calculate();
    }
    else if (_operations.containsKey(input)) {
      _setOperator(input);
    }
    else {
      _appendNumber(input);
    }

  }

  void _calculate() {

    if (_operator.isEmpty) return;

    double num1 = double.parse(_previousInput);
    double num2 = double.parse(_currentInput);

    Operation operation = _operations[_operator]!;

    double result = operation.execute(num1, num2);

    _equation = '$_previousInput $_operator $_currentInput =';

    _currentInput = _formatter.format(result);

    _previousInput = '';
    _operator = '';
    _shouldResetInput = true;

  }

  void _setOperator(String op) {

    _operator = op;
    _previousInput = _currentInput;
    _equation = '$_previousInput $_operator';
    _shouldResetInput = true;

  }

  void _appendNumber(String num) {

    if (_shouldResetInput) {
      _currentInput = num;
      _shouldResetInput = false;
    }
    else {
      if (_currentInput == '0') {
        _currentInput = num;
      }
      else {
        _currentInput += num;
      }
    }

  }

  void _clear() {

    _currentInput = '0';
    _previousInput = '';
    _operator = '';
    _equation = '';
    _shouldResetInput = false;

  }

}