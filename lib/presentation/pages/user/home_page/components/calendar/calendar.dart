import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'active_calendar_day.dart';


class Calendar extends StatelessWidget {
  final String startTime;
  final String endTime;
  final bool isActive;

  const Calendar(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('dd.MM.yyyy');
    DateTime startDate = dateFormat.parse(startTime);
    DateTime endDate = dateFormat.parse(endTime);

    return TableCalendar(
      daysOfWeekHeight: 32,
      locale: 'ru',
      headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 22)),
      calendarStyle:
          const CalendarStyle(defaultTextStyle: TextStyle(color: Colors.black)),
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      calendarBuilders: CalendarBuilders(todayBuilder: (context, day, _) {
        if (day.isGreaterOrEquals(startDate) &&
            day.isLowerOrEquals(endDate)) {
          return ActiveCalendarDay(dayNumber: day.day.toString());
        }
      }, defaultBuilder: (context, day, focusedDay) {
        if (day.isGreaterOrEquals(startDate) &&
            day.isLowerOrEquals(endDate)) {
          return ActiveCalendarDay(dayNumber: day.day.toString());
        }
      }),
    );
  }
}

extension DateOnly on DateTime {
  bool isGreaterOrEquals(DateTime other) {
    return year >= other.year && month >= other.month
        && day >= other.day;
  }
  bool isLowerOrEquals(DateTime other) {
    return year <= other.year && month <= other.month
        && day <= other.day;
  }
}
