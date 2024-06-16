import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPasswordDirty = false;

  final List<Map<String, dynamic>> _passwordValidations = [
    {'message': 'Minimum length - 8 characters', 'isValid': false},
    {'message': 'Maximum length - 64 characters', 'isValid': true},
    {'message': 'Contains at least 1 uppercase letter', 'isValid': false},
    {'message': 'Contains at least 1 digit', 'isValid': false},
  ];

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordValidation);
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
      _isPasswordDirty = password.isNotEmpty;
      _passwordValidations[0]['isValid'] = password.length >= 8;
      _passwordValidations[1]['isValid'] = password.length <= 64;
      _passwordValidations[2]['isValid'] = password.contains(RegExp(r'[A-Z]'));
      _passwordValidations[3]['isValid'] = password.contains(RegExp(r'[0-9]'));
    });
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
        style: Theme.of(context).inputDecorationTheme.errorStyle,
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
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
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
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (_passwordValidations
                        .any((validation) => !validation['isValid'])) {
                      return '';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 8),
                ..._passwordValidations.map((validation) =>
                    _buildValidationText(
                        validation['message'], validation['isValid'])),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}