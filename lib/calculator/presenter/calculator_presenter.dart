import 'package:flutter/foundation.dart';
import '../entity/calculator_entity.dart';
import '../interactor/i_calculator_interactor.dart';
import 'i_calculator_presenter.dart';

/// DIP Fix: Depends on [ICalculatorInteractor] (abstraction), not the concrete class.
/// ISP Fix: Implements [ICalculatorPresenter] to expose a minimal contract to the View.
class CalculatorPresenter extends ChangeNotifier implements ICalculatorPresenter {
  final ICalculatorInteractor _interactor;
  CalculatorEntity _entity = const CalculatorEntity();

  CalculatorPresenter(this._interactor);

  @override
  CalculatorEntity get entity => _entity;

  @override
  void onInputPressed(String input) {
    _interactor.handleInput(input);
    _entity = _entity.copyWith(
      displayValue: _interactor.displayValue,
      equation: _interactor.equation,
    );
    notifyListeners();
  }

  @override
  void toggleTheme() {
    _entity = _entity.copyWith(isDarkMode: !_entity.isDarkMode);
    notifyListeners();
  }
}

