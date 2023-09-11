import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessDialog extends StatelessWidget {
  final String bodyText;

  const SuccessDialog({super.key, required this.bodyText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      content: Text(bodyText),
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Закрыть'),
        )
      ],
    );
  }
}
