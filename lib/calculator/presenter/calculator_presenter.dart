import 'package:flutter/foundation.dart';
import '../entity/calculator_entity.dart';
import '../interactor/calculator_interactor.dart';

class CalculatorPresenter extends ChangeNotifier {
  final CalculatorInteractor _interactor;
  CalculatorEntity _entity = const CalculatorEntity();

  CalculatorPresenter(this._interactor);

  CalculatorEntity get entity => _entity;

  void onInputPressed(String input) {
    _interactor.handleInput(input);
    _entity = _entity.copyWith(
      displayValue: _interactor.displayValue,
      equation: _interactor.equation,
    );
    notifyListeners();
  }

  void toggleTheme() {
    _entity = _entity.copyWith(isDarkMode: !_entity.isDarkMode);
    notifyListeners();
  }
}
