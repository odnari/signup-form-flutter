import 'package:flutter/material.dart';
import 'package:signup_form_flutter/constants/app_theme.dart';
import 'package:signup_form_flutter/utils/validation_result.dart';

class ValidationMessages extends StatelessWidget {
  const ValidationMessages({
    super.key,
    required this.messages,
    this.color,
  });

  final List<ValidationResult> messages;
  final Color? color;

  getMessageColor(ValidationResult message) {
    if (color != null) {
      return color;
    }

    if (message.isValid) {
      return AppColors.successColor;
    } else {
      return AppColors.errorColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final message in messages)
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text(
              message.message,
              style:
                  Theme.of(context).inputDecorationTheme.errorStyle?.copyWith(
                        color: getMessageColor(message),
                      ),
            ),
          ),
      ],
    );
  }
}
