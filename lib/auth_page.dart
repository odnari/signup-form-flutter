import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:signup_form_flutter/theme/app_theme.dart';
import 'package:signup_form_flutter/widgets/gradient_button.dart';
import 'dart:async';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  Timer? _debounce;

  final List<Map<String, dynamic>> _passwordValidations = [
    {'message': 'Minimum length - 8 characters', 'isValid': false},
    {'message': 'Maximum length - 64 characters', 'isValid': true},
    {'message': 'Contains at least 1 uppercase letter', 'isValid': false},
    {'message': 'Contains at least 1 digit', 'isValid': false},
  ];

  final Map<String, dynamic> _emailValidation = {
    'message': 'Email is not valid',
    'isValid': false
  };

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordValidation);
    _emailController.addListener(_updateEmailValidation);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updatePasswordValidation() {
    final password = _passwordController.text;
    setState(() {
      _passwordValidations[0]['isValid'] = password.length >= 8;
      _passwordValidations[1]['isValid'] = password.length <= 64;
      _passwordValidations[2]['isValid'] = password.contains(RegExp(r'[A-Z]'));
      _passwordValidations[3]['isValid'] = password.contains(RegExp(r'[0-9]'));
    });
  }

  void _updateEmailValidation() {
    final email = _emailController.text;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 700),
      () {
        setState(() {
          _emailValidation['isValid'] = EmailValidator.validate(email);
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  Widget _buildValidationText(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: Theme.of(context).inputDecorationTheme.errorStyle?.copyWith(
              color: isValid
                  ? Colors.green
                  : Theme.of(context).inputDecorationTheme.errorStyle?.color,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextInput(
                    emailController: _emailController,
                    emailValidation: _emailValidation),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Create your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    errorStyle: const TextStyle(height: 0),
                    errorText: null,
                    error: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _passwordValidations
                          .map((validation) => _buildValidationText(
                              validation['message'], validation['isValid']))
                          .toList(),
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                ),
                const SizedBox(height: 24),
                GradientButton(label: 'Sign Up', onPressed: _submitForm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required TextEditingController emailController,
    required Map<String, dynamic> emailValidation,
  })  : _emailController = emailController,
        _emailValidation = emailValidation;

  final TextEditingController _emailController;
  final Map<String, dynamic> _emailValidation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        errorText:
            _emailValidation['isValid'] ? null : _emailValidation['message'],
        enabledBorder:
            Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
                  borderSide: BorderSide(
                    color: _emailValidation['isValid']
                        ? AppColors.successColor
                        : Theme.of(context)
                            .inputDecorationTheme
                            .focusedBorder!
                            .borderSide
                            .color,
                  ),
                ),
        focusedBorder:
            Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
                  borderSide: BorderSide(
                    color: _emailValidation['isValid']
                        ? AppColors.successColor
                        : Theme.of(context)
                            .inputDecorationTheme
                            .focusedBorder!
                            .borderSide
                            .color,
                  ),
                ),
      ),
      style: TextStyle(
        color: _emailValidation['isValid']
            ? AppColors.successColor
            : AppColors.secondaryColor,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
