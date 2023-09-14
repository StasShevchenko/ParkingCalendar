import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FailureDialog extends StatelessWidget {
  final String? description;

  const FailureDialog({super.key, this.description});

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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Кажется что-то пошло не так! Повторите операцию снова.'),
          if(description != null) ...{
            SizedBox(height: 8,),
            Text(description!)
          }
        ],
      ),
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
