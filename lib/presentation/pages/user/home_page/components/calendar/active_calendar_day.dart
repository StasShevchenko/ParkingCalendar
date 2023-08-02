import 'package:flutter/material.dart';

import '../../../../../../assets/colors/app_colors.dart';


/// This widget is used to highlight
/// day that is available for parking
class ActiveCalendarDay extends StatelessWidget {
  const ActiveCalendarDay({super.key, required this.dayNumber});

  final String dayNumber;

  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryAccentRed,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Center(
          child: Text(
            dayNumber,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
