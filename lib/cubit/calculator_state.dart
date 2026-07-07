class CalculatorState {
  const CalculatorState({
    this.displayValue = '0',
    this.previousValue = '',
    this.operator,
    this.isNewEquation = false,
    this.equation = '',
  });

  final String displayValue;
  final String previousValue;
  final String? operator;
  final bool isNewEquation;
  final String equation;

  CalculatorState copyWith({
    String? displayValue,
    String? previousValue,
    String? operator,
    bool? isNewEquation,
    String? equation,
  }) {
    return CalculatorState(
      displayValue: displayValue ?? this.displayValue,
      previousValue: previousValue ?? this.previousValue,
      operator: operator ?? this.operator,
      isNewEquation: isNewEquation ?? this.isNewEquation,
      equation: equation ?? this.equation,
    );
  }
}
