import 'package:flutter/material.dart';

import '../../../../../assets/colors/app_colors.dart';
import '../../../../../utils/number_to_month.dart';

class QueueHeader extends StatelessWidget {
  final String monthName;

  const QueueHeader({super.key, required this.monthName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: monthName == numberToMonth(DateTime.now().month)
                  ? AppColors.primaryBlue
                  : AppColors.background,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                monthName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: monthName == numberToMonth(DateTime.now().month)
                        ? AppColors.primaryWhite
                        : AppColors.secondaryBlue),
              )),
        ),
      ),
    );
  }
}
