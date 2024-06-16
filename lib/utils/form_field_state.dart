import 'package:signup_form_flutter/utils/validation_result.dart';
import 'package:signup_form_flutter/utils/validation_rule.dart';

List<ValidationResult> mapRulesToValidationMessages(
    List<ValidationRule> rules) {
  return rules
      .map((ValidationRule rule) => ValidationResult(
            isValid: false,
            message: rule.message,
          ))
      .toList();
}

class FormFieldState {
  FormFieldState({
    this.isValid = false,
    this.isDirty = false,
    required this.validationRules,
  }) {
    validationResults = mapRulesToValidationMessages(validationRules);
  }

  bool isValid;
  bool isDirty;
  String value = '';
  List<ValidationRule> validationRules;
  late List<ValidationResult> validationResults;

  validate() {
    validationRules.asMap().forEach((index, rule) {
      validationResults[index].isValid = rule.validator(value);
    });

    isValid = validationResults.every((element) => element.isValid);
  }
}
