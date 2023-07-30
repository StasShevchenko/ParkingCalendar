import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('App title'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Welcome my to this event my friends', style: Theme.of(context).textTheme.bodyLarge,),
              const SizedBox(height: 20,),
              TextField(
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  labelText: 'Pls enter something'
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: (){}, child: const Text('Click me!'))
            ],
          ),
        ),
      )
    );
  }
}
