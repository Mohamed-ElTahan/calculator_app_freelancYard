import 'package:bloc/bloc.dart';
import 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(const CalculatorState());

  void numberPressed(String number) {
    if (state.isNewEquation) {
      emit(state.copyWith(displayValue: '0', isNewEquation: false, equation: ''));
    }

    final current = state.displayValue;
    if (current == '0' && number != '.') {
      emit(state.copyWith(displayValue: number));
      return;
    }

    if (number == '.' && current.contains('.')) {
      return;
    }

    emit(state.copyWith(displayValue: current + number));
  }

  void operatorPressed(String op) {
    if (state.displayValue == 'Error') {
      return;
    }

    emit(
      state.copyWith(
        previousValue: state.displayValue,
        displayValue: '0',
        operator: op,
        isNewEquation: false,
        equation: '${state.displayValue} $op',
      ),
    );
  }

  void calculateResult() {
    if (state.operator == null || state.previousValue.isEmpty) {
      return;
    }

    final previous = double.tryParse(state.previousValue);
    final current = double.tryParse(state.displayValue);

    if (previous == null || current == null) {
      emit(state.copyWith(displayValue: 'Error'));
      return;
    }

    late double result;
    switch (state.operator) {
      case '+':
        result = previous + current;
        break;
      case '-':
        result = previous - current;
        break;
      case '*':
        result = previous * current;
        break;
      case '/':
        if (current == 0) {
          emit(state.copyWith(displayValue: 'Error'));
          return;
        }
        result = previous / current;
        break;
      default:
        return;
    }

    final resultString = result.toStringAsFixed(
      result.truncateToDouble() == result ? 0 : 2,
    );
    emit(
      state.copyWith(
        displayValue: resultString,
        previousValue: '',
        operator: null,
        isNewEquation: true,
        equation: '${state.previousValue} ${state.operator} ${state.displayValue} =',
      ),
    );
  }

  void clear() {
    emit(const CalculatorState());
  }
}
