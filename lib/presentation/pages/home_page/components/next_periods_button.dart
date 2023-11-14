import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/home_page/components/next_periods_dialog.dart';

class NextPeriodsButton extends StatelessWidget {
  const NextPeriodsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          minHeight: 25, maxHeight: 25, minWidth: 270, maxWidth: 270),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const NextPeriodsDialog());
        },
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: const Text(
          "Смотреть следующие периоды",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        ),
      ),
    );
  }
}
