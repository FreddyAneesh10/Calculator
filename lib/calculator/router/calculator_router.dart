import 'package:flutter/material.dart';

import '../interactor/calculator_interactor.dart';
import '../presenter/calculator_presenter.dart';
import '../view/calculator_view.dart';

import '../operations/add_operation.dart';
import '../operations/subtract_operation.dart';
import '../operations/multiply_operation.dart';
import '../operations/divide_operation.dart';
import '../operations/operation.dart';

import '../services/result_formatter.dart';

class CalculatorRouter {

  static Widget createModule() {

    final operations = <String, Operation>{
      '+': AddOperation(),
      '−': SubtractOperation(),
      '×': MultiplyOperation(),
      '÷': DivideOperation(),
    };

    final formatter = ResultFormatter();

    final interactor = CalculatorInteractor(
      operations: operations,
      formatter: formatter,
    );

    final presenter = CalculatorPresenter(interactor);

    return CalculatorView(presenter: presenter);
  }

}