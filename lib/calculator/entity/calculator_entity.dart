class CalculatorEntity {
  final String displayValue;
  final String equation;
  final bool isDarkMode;

  const CalculatorEntity({
    this.displayValue = '0',
    this.equation = '',
    this.isDarkMode = false,
  });

  CalculatorEntity copyWith({
    String? displayValue,
    String? equation,
    bool? isDarkMode,
  }) {
    return CalculatorEntity(
      displayValue: displayValue ?? this.displayValue,
      equation: equation ?? this.equation,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
