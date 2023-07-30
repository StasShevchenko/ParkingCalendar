import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/login_page/login_page.dart';
import 'package:parking_project/presentation/theme/app_colors.dart';
import 'package:parking_project/presentation/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
