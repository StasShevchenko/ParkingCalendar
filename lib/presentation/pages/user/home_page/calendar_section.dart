import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';
import 'components/calendar/calendar.dart';

class CalendarSection extends StatelessWidget {
  final String startDate;
  final String endDate;
  const CalendarSection({super.key, required this.startDate, required this.endDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Здравствуйте, Михаил!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: AppColors.primaryAccentRed,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const Text(' дни доступа к парковке')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: AppColors.primaryWhite,
              surfaceTintColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Calendar(
                  startTime: startDate,
                  endTime: endDate,
                  isActive: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
