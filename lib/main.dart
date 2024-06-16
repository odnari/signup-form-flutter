import 'package:flutter/material.dart';
import 'package:signup_form_flutter/constants/app_theme.dart';
import 'views/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: AppTheme.light,
      home: const AuthPage(),
    );
  }
}
