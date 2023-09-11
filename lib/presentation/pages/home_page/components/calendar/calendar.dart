import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'active_calendar_day.dart';


class Calendar extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  const Calendar(
      {super.key,
      required this.startDate,
      required this.endDate,
     });

  @override
  Widget build(BuildContext context) {

    return TableCalendar(
      daysOfWeekHeight: 32,
      locale: 'ru',
      headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 22)),
      calendarStyle:
          const CalendarStyle(defaultTextStyle: TextStyle(color: Colors.black), isTodayHighlighted: false),
      focusedDay: startDate,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      calendarBuilders: CalendarBuilders(
        outsideBuilder: (context, day, focusedDay) {
          if (day.isGreaterOrEquals(startDate) &&
              day.isLowerOrEquals(endDate)) {
            return ActiveCalendarDay(dayNumber: day.day.toString(), alpha: 50,);
          }
        },
          defaultBuilder: (context, day, focusedDay) {
        if (day.isGreaterOrEquals(startDate) &&
            day.isLowerOrEquals(endDate)) {
          return ActiveCalendarDay(dayNumber: day.day.toString(), alpha: 255,);
        }
      }),
    );
  }
}

extension DateOnly on DateTime {
  bool isGreaterOrEquals(DateTime other) {
    final currentDate = DateTime(year, month, day);
    final otherDate = DateTime(other.year, other.month, other.day);
    return currentDate.difference(otherDate).inDays >= 0 ? true : false;
  }
  bool isLowerOrEquals(DateTime other) {
    final currentDate = DateTime(year, month, day);
    final otherDate = DateTime(other.year, other.month, other.day);
    return currentDate.difference(otherDate).inDays > 0 ? false : true;
  }
}
