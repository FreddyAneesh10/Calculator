import 'package:flutter/material.dart';
import '../interactor/calculator_interactor.dart';
import '../presenter/calculator_presenter.dart';
import '../view/calculator_view.dart';

class CalculatorRouter {
  static Widget createModule() {
    final interactor = CalculatorInteractor();
    final presenter = CalculatorPresenter(interactor);
    return CalculatorView(presenter: presenter);
  }
}
