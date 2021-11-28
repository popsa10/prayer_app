import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/cubits/app_cubit/app_cubit.dart';
import 'package:prayer_app/screens/home_page_screen.dart';
import 'package:table_calendar/table_calendar.dart';

Widget buildDivider() {
  return const Divider(
    thickness: 3,
    height: 2,
    color: Colors.blueAccent,
  );
}

Widget buildPrayerWithTimeItem({String text, String date}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
            Expanded(
                child: Text(
              DateFormat.jm().format(DateFormat("h:m").parse(date)),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
      buildDivider()
    ],
  );
}

Widget buildCustomButton({BuildContext context, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(20),
      child: const Text(
        "Login,Please",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget buildCustomTableCalender(
    {CalendarController controller, AppCubit cubit}) {
  return Container(
    decoration: BoxDecoration(color: Colors.blueAccent.shade100),
    child: TableCalendar(
      startDay: DateTime(2010),
      endDay: DateTime(2030),
      calendarController: controller,
      calendarStyle: const CalendarStyle(
        highlightToday: true,
        selectedColor: Colors.greenAccent,
      ),
      initialCalendarFormat: CalendarFormat.week,
      onCalendarCreated: (first, last, format) {
        cubit.onDaySelected(value: first);
      },
      onDaySelected: (day, events, holidays) {
        cubit.onDaySelected(value: day);
      },
    ),
  );
}
