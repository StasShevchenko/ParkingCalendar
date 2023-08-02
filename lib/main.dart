import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:parking_project/assets/themes/theme.dart';
import 'package:parking_project/presentation/pages/user/home_page/home_page.dart';

void main() {
  initializeDateFormatting('ru').then((_) => runApp( const MyApp()
  ));
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
    return const UserHomePage();
  }
}
