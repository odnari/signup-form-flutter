import 'package:flutter/material.dart';
import 'package:signup_form_flutter/constants/app_theme.dart';
import 'package:signup_form_flutter/utils/validation_result.dart';
import 'package:signup_form_flutter/widgets/validation_messages.dart';

class FormTextInput extends StatelessWidget {
  const FormTextInput({
    super.key,
    this.isDirty = false,
    this.obscureText = false,
    this.errorStyle,
    this.hintText,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.validationMessages,
    this.alwaysShowValidation,
  });

  final bool isDirty;
  final bool obscureText;
  final TextStyle? errorStyle;
  final String? hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final List<ValidationResult>? validationMessages;
  final bool? alwaysShowValidation;

  @override
  Widget build(BuildContext context) {
    Color inputColor = AppColors.primaryColor;
    Color textColor = AppColors.secondaryColor;
    bool isValid = validationMessages?.every((v) => v.isValid) ?? false;
    bool showValidation =
        alwaysShowValidation == true || (isDirty == true && isValid == false);

    if (isDirty == true) {
      if (isValid == true) {
        inputColor = AppColors.successColor;
        textColor = AppColors.successColor;
      } else {
        inputColor = AppColors.errorColor;
        textColor = AppColors.errorColor;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: null,
            errorStyle: const TextStyle(height: 0),
            suffixIcon: suffixIcon,
            enabledBorder:
                Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
                      borderSide: BorderSide(
                        color: inputColor,
                      ),
                    ),
            focusedBorder:
                Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
                      borderSide: BorderSide(
                        color: inputColor,
                      ),
                    ),
          ),
          style: TextStyle(
            color: textColor,
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
        ),
        if (showValidation && validationMessages != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            child: ValidationMessages(
              messages: validationMessages!,
              color: isDirty ? null : textColor,
            ),
          ),
      ],
    );
  }
}
