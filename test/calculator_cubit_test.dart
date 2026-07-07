import 'package:calculator_app/cubit/calculator_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculatorCubit', () {
    late CalculatorCubit cubit;

    setUp(() {
      cubit = CalculatorCubit();
    });

    test('starts with zero displayed', () {
      expect(cubit.state.displayValue, '0');
    });

    test('appends digits and evaluates addition', () {
      cubit.numberPressed('7');
      cubit.numberPressed('8');
      cubit.operatorPressed('+');
      cubit.numberPressed('3');
      cubit.calculateResult();

      expect(cubit.state.displayValue, '81');
    });

    test('clears the calculator state', () {
      cubit.numberPressed('5');
      cubit.clear();

      expect(cubit.state.displayValue, '0');
      expect(cubit.state.previousValue, '');
      expect(cubit.state.operator, null);
    });
  });
}
