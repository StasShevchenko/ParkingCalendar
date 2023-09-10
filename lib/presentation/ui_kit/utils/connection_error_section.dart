import 'package:flutter/material.dart';

class ConnectionErrorSection extends StatelessWidget {
  final Function onButtonClicked;

  const ConnectionErrorSection({super.key, required this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ошибка!\n Проверьте ваше подключение к интернету!',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
               onButtonClicked();
              },
              child: const Text('Обновить'))
        ],
      ),
    );
  }
}
