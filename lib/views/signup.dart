import 'package:flutter/material.dart' hide FormFieldState;
import 'package:signup_form_flutter/utils/form_field_state.dart';
import 'package:signup_form_flutter/utils/validation_rules.dart';
import 'package:signup_form_flutter/widgets/form_text_input.dart';
import 'package:signup_form_flutter/widgets/gradient_button.dart';
import 'dart:async';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isPasswordVisible = false;
  Timer? _debounce;

  final Map<String, FormFieldState> _formFields = {
    'email': FormFieldState(
      validationRules: emailValidationRules,
    ),
    'password': FormFieldState(
      validationRules: passwordValidationRules,
    ),
  };

  void _onPasswordChanged(String password) {
    setState(() {
      FormFieldState passwordField = _formFields['password']!;
      passwordField.value = password;
      passwordField.validate();
      passwordField.isDirty = true;
    });
  }

  void _onEmailChanged(String email) {
    FormFieldState emailField = _formFields['email']!;
    emailField.value = email;

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 700),
      () {
        setState(() {
          FormFieldState emailField = _formFields['email']!;
          emailField.validate();
          emailField.isDirty = true;
        });
      },
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Sign up successful!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void validateForm() {
    setState(() {
      for (final field in _formFields.values) {
        field.isDirty = true;
        field.validate();
      }
    });
  }

  bool isFormValid() {
    for (final field in _formFields.values) {
      if (!field.isValid) {
        return false;
      }
    }

    return true;
  }

  void _submitForm() {
    validateForm();

    if (isFormValid()) {
      _showSuccessDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.contain,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(244, 249, 255, 1),
              Color.fromRGBO(224, 237, 251, 1)
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign up",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                FormTextInput(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  isDirty: _formFields['email']!.isDirty,
                  validationMessages: _formFields['email']!.validationResults,
                  onChanged: _onEmailChanged,
                ),
                const SizedBox(height: 24),
                FormTextInput(
                  isDirty: _formFields['password']!.isDirty,
                  hintText: 'Create your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  validationMessages:
                      _formFields['password']!.validationResults,
                  alwaysShowValidation: true,
                  obscureText: !_isPasswordVisible,
                  onChanged: _onPasswordChanged,
                ),
                const SizedBox(height: 32),
                GradientButton(label: 'Sign Up', onPressed: _submitForm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
