import '../entity/calculator_entity.dart';

abstract class ICalculatorPresenter {
  CalculatorEntity get entity;
  void onInputPressed(String input);
  void toggleTheme();
}
