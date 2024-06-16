class ValidationRule {
  const ValidationRule({required this.message, required this.validator});

  final String message;
  final bool Function(String) validator;
}

