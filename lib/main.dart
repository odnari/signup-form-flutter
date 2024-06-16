import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signup_form_flutter/constants/app_theme.dart';
import 'views/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Sign Up Flutter',
      theme: AppTheme.light,
      home: const AuthPage(),
    );
  }
}
