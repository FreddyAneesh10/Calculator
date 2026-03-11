import 'dart:math';

class CalculatorInteractor {
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
    } else if (input == '⌫') {
      _backspace();
    } else if (input == '=') {
      _calculate();
    } else if (input == '±') {
      _toggleSign();
    } else if (input == '%') {
      _percent();
    } else if (input == '√') {
      _sqrt();
    } else if (input == '()') {
      _parentheses();
    } else if (_isOperator(input)) {
      _setOperator(input);
    } else {
      _appendNumber(input);
    }
  }

  void _clear() {
    _currentInput = '0';
    _previousInput = '';
    _operator = '';
    _equation = '';
    _shouldResetInput = false;
  }

  void _backspace() {
    if (_shouldResetInput) return;
    if (_currentInput.length > 1) {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
    } else {
      _currentInput = '0';
    }
  }

  void _calculate() {
    if (_operator.isEmpty || _previousInput.isEmpty) return;
    
    String parseCurrent = _currentInput.replaceAll(',', '.');
    String parsePrec = _previousInput.replaceAll(',', '.');
    
    double num1 = double.tryParse(parsePrec) ?? 0;
    double num2 = double.tryParse(parseCurrent) ?? 0;
    double result = 0;
    
    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '−':
      case '-':
        result = num1 - num2;
        break;
      case '×':
      case '*':
        result = num1 * num2;
        break;
      case '÷':
      case '/':
        if (num2 != 0) {
            result = num1 / num2;
        } else {
            _currentInput = 'Error';
            _equation = '$_previousInput $_operator $_currentInput =';
            _operator = '';
            _previousInput = '';
            _shouldResetInput = true;
            return;
        }
        break;
    }
    
    _equation = '$_previousInput $_operator $_currentInput =';
    _currentInput = _formatResult(result);
    _operator = '';
    _previousInput = '';
    _shouldResetInput = true;
  }

  void _toggleSign() {
     if (_currentInput != '0' && _currentInput != 'Error') {
         if (_currentInput.startsWith('-')) {
             _currentInput = _currentInput.substring(1);
         } else {
             _currentInput = '-$_currentInput';
         }
     }
  }

  void _percent() {
      if (_currentInput == 'Error') return;
      String parseCurrent = _currentInput.replaceAll(',', '.');
      double num = double.tryParse(parseCurrent) ?? 0;
      _equation = '$_currentInput %';
      _currentInput = _formatResult(num / 100);
      _shouldResetInput = true;
  }

  void _sqrt() {
      if (_currentInput == 'Error') return;
      String parseCurrent = _currentInput.replaceAll(',', '.');
      double num = double.tryParse(parseCurrent) ?? 0;
      if (num >= 0) {
          _equation = '√($_currentInput)';
          _currentInput = _formatResult(sqrt(num));
      } else {
          _currentInput = 'Error';
      }
      _shouldResetInput = true;
  }

  void _parentheses() {
     // A simple placeholder for ()
     if (_currentInput == '0') {
         _currentInput = '(';
     } else if (_currentInput.contains('(') && !_currentInput.contains(')')) {
         _currentInput += ')';
     } else {
         _currentInput += '(';
     }
  }

  void _setOperator(String op) {
    if (_currentInput == 'Error') _currentInput = '0';
    if (_operator.isNotEmpty && !_shouldResetInput) {
       _calculate();
    }
    _operator = op;
    _previousInput = _currentInput;
    _equation = '$_previousInput $_operator';
    _shouldResetInput = true;
  }

  void _appendNumber(String numString) {
    if (_currentInput == 'Error') _currentInput = '0';

    if (_shouldResetInput) {
      if (numString == ',') {
         _currentInput = '0,';
      } else {
         _currentInput = numString;
      }
      _shouldResetInput = false;
    } else {
      if (numString == ',' && _currentInput.contains(',')) return;
      
      if (_currentInput == '0' && numString != ',') {
        _currentInput = numString;
      } else {
        _currentInput += numString;
      }
    }
  }

  bool _isOperator(String input) {
    return input == '+' || input == '−' || input == '×' || input == '÷';
  }

  String _formatResult(double result) {
    String res = result.toString();
    if (res.endsWith('.0')) {
      res = res.substring(0, res.length - 2);
    }
    return res.replaceAll('.', ',');
  }
}
