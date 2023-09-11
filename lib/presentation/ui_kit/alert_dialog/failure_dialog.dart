import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FailureDialog extends StatelessWidget {
  const FailureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Center(
        child: Text(
          'Ошибка',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      content: const Text('Кажется что-то пошло не так! Повторите операцию снова.'),
      actions: [
        ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Закрыть'))
      ],
    );
  }
}
