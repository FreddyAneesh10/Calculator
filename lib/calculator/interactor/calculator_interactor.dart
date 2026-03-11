import '../operations/operation.dart';
import '../operations/unary_operation.dart';
import '../services/i_result_formatter.dart';
import 'i_calculator_interactor.dart';

/// OCP Fix: [handleInput] no longer contains an if/else chain that must
/// be edited to support new commands. Instead, a [_commandRegistry] maps
/// each special token to a callback. Registering a new command (e.g. '%')
/// only requires adding one entry — no existing logic is modified.
///
/// DIP Fix: Depends on [IResultFormatter] (abstraction), not the concrete
/// [ResultFormatter]. Implements [ICalculatorInteractor] so the Presenter
/// depends on this abstraction, not the concrete class.
class CalculatorInteractor implements ICalculatorInteractor {

  final IResultFormatter _formatter;
  final Map<String, Operation> _operations;
  final Map<String, UnaryOperation> _unaryOperations;

  CalculatorInteractor({
    required Map<String, Operation> operations,
    required Map<String, UnaryOperation> unaryOperations,
    required IResultFormatter formatter,
  })  : _operations = operations,
        _unaryOperations = unaryOperations,
        _formatter = formatter {
    // OCP: build the command registry once at construction time.
    _registerCommands();
  }

  String _currentInput = '0';
  String _previousInput = '';
  String _operator = '';
  String _equation = '';
  bool _shouldResetInput = false;

  /// OCP: Maps each special input token to its handler.
  /// To add a new command, register it here — nothing else changes.
  late final Map<String, void Function()> _commandRegistry;

  void _registerCommands() {
    _commandRegistry = {
      'C': _clear,
      '=': _calculate,
      '⌫': _backspace,
    };
  }

  @override
  String get displayValue => _currentInput;

  @override
  String get equation => _equation;

  @override
  void handleInput(String input) {
    // OCP: look up the command registry first.
    final command = _commandRegistry[input];
    if (command != null) {
      command();
    } else if (_unaryOperations.containsKey(input)) {
      _executeUnaryOperation(input);
    } else if (_operations.containsKey(input)) {
      _setOperator(input);
    } else {
      _appendNumber(input);
    }
  }

  void _executeUnaryOperation(String op) {
    double value = double.parse(_currentInput);
    UnaryOperation operation = _unaryOperations[op]!;
    
    double result = operation.execute(value);
    
    // Formatting the string to match standard scientific calculator view using polymorphism (OCP fix)
    _equation = operation.formatEquation(_currentInput);
    
    _currentInput = _formatter.format(result);
    _shouldResetInput = true;
  }

  void _calculate() {

    if (_operator.isEmpty) return;

    double num1 = double.parse(_previousInput);
    double num2 = double.parse(_currentInput);

    Operation operation = _operations[_operator]!;

    double result = operation.execute(num1, num2);

    _equation = operation.formatEquation(_previousInput, _currentInput);

    _currentInput = _formatter.format(result);

    _previousInput = '';
    _operator = '';
    _shouldResetInput = true;

  }

  void _setOperator(String op) {

    _operator = op;
    _previousInput = _currentInput;
    _equation = _operations[_operator]!.formatOngoingEquation(_previousInput);
    _shouldResetInput = true;

  }

  void _appendNumber(String num) {

    if (_shouldResetInput) {
      _currentInput = num;
      _shouldResetInput = false;
    } else {
      if (_currentInput == '0') {
        _currentInput = num;
      } else {
        _currentInput += num;
      }
    }

  }

  void _backspace() {
    if (_shouldResetInput || _currentInput.length <= 1) {
      _currentInput = '0';
      _shouldResetInput = false;
    } else {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
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