import 'package:flutter/material.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/pages/home_page/components/card_reminder_dialog/card_reminder_dialog.dart';
import 'package:parking_project/presentation/pages/home_page/components/welcome_title.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../../../assets/colors/app_colors.dart';
import 'calendar/calendar.dart';

class CalendarSection extends StatelessWidget {
  final UserInfo userInfo;

  const CalendarSection({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    final indicatorWidthFactor = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 0.8,
      FormFactorType.Tablet => 0.7,
      FormFactorType.Desktop => 0.6
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (userInfo.isActive) ...{
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  children: [
                    WelcomeTitle(
                      isReminderNeeded: userInfo.nextUserId != null,
                      onReminderClicked: () {
                        if (userInfo.nextUserId != null) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CardReminderDialog(
                                    isForNext: true, userId: userInfo.nextUserId!);
                              });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 32,
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
                      height: 16,
                    ),
                    Card(
                      color: AppColors.primaryWhite,
                      surfaceTintColor: AppColors.primaryWhite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Calendar(
                          startDate: userInfo.startDate!,
                          endDate: userInfo.endDate!,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            } else ...{
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.width < 880
                        ? 400
                        : double.infinity,
                    maxWidth: MediaQuery.of(context).size.width < 880
                        ? 400
                        : double.infinity),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: WelcomeTitle(
                          isReminderNeeded: userInfo.previousUserId != null,
                          onReminderClicked: () {
                            if (userInfo.previousUserId != null) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CardReminderDialog(
                                        isForNext: false,
                                        userId: userInfo.previousUserId!);
                                  });
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'До вашей очереди\n осталось ${userInfo.startDate!.difference(DateTime.now()).inDays} дней!',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          FractionallySizedBox(
                            widthFactor: indicatorWidthFactor,
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: CircularProgressIndicator(
                                strokeWidth: DeviceScreen.get(context) ==
                                        FormFactorType.Desktop
                                    ? 14
                                    : 10,
                                value: (userInfo.startDate!
                                        .difference(DateTime.now())
                                        .inDays /
                                    userInfo.startDate!
                                        .difference(userInfo.lastActiveDate!)
                                        .inDays),
                                color: AppColors.primaryAccentRed,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            },
          ],
        ),
      ),
    );
  }
}
