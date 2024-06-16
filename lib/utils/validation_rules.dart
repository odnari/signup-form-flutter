import 'package:email_validator/email_validator.dart';
import 'package:signup_form_flutter/utils/validation_rule.dart';

final List<ValidationRule> passwordValidationRules = [
  ValidationRule(
    message: "8 characters or more (no spaces)",
    validator: (text) => !RegExp(r'\s').hasMatch(text) && text.length >= 8,
  ),
  ValidationRule(
    message: "Uppercase and lowercase letters",
    validator: (text) =>
    text.contains(RegExp(r'[a-z]')) && text.contains(RegExp(r'[A-Z]')),
  ),
  ValidationRule(
    message: "At least one digit ",
    validator: (text) => text.contains(RegExp(r'\d')),
  ),
];

final List<ValidationRule> emailValidationRules = [
  ValidationRule(
    message: "Email is not valid",
    validator: (text) => EmailValidator.validate(text),
  ),
];