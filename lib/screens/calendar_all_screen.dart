import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/habit.dart';

class CalendarAllScreen extends StatefulWidget {
  final List<Habit> allHabits;

  CalendarAllScreen({required this.allHabits});

  @override
  _CalendarAllScreenState createState() => _CalendarAllScreenState();
}

class _CalendarAllScreenState extends State<CalendarAllScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<String> _completedHabits = [];

  Map<DateTime, int> _buildCompletionMap() {
    Map<DateTime, int> completedPerDay = {};
    for (var habit in widget.allHabits) {
      for (var d in habit.completedDates) {
        final day = DateTime(d.year, d.month, d.day);
        completedPerDay[day] = (completedPerDay[day] ?? 0) + 1;
      }
    }
    return completedPerDay;
  }

  List<String> _getHabitsCompletedOn(DateTime day) {
    return widget.allHabits.where((habit) {
      return habit.completedDates.any(
        (d) => d.year == day.year && d.month == day.month && d.day == day.day,
      );
    }).map((h) => h.title).toList();
  }

  Widget _buildDayCell(BuildContext context, DateTime day, DateTime focusedDay) {
    final completedMap = _buildCompletionMap();
    final total = widget.allHabits.length;
    final count = completedMap[DateTime(day.year, day.month, day.day)] ?? 0;
    final ratio = total > 0 ? count / total : 0.0;

    Color? bg;
    if (ratio == 1) {
      bg = Colors.green[400];
    } else if (ratio > 0) {
      bg = Colors.orange[300];
    }

    return Container(
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${day.day}', style: TextStyle(fontSize: 12)),
          if (count > 0)
            Text('$count/$total', style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalHabits = widget.allHabits.length;

    return Scaffold(
      appBar: AppBar(title: Text("All Habits Calendar")),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            selectedDayPredicate: (day) =>
                _selectedDay != null &&
                day.year == _selectedDay!.year &&
                day.month == _selectedDay!.month &&
                day.day == _selectedDay!.day,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _completedHabits = _getHabitsCompletedOn(selectedDay);
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: _buildDayCell,
              selectedBuilder: _buildDayCell,
            ),
          ),
          if (_selectedDay != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Completed on ${_selectedDay!.month}/${_selectedDay!.day}:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  if (_completedHabits.isEmpty)
                    Text("No habits completed."),
                  ..._completedHabits.map((h) => Text('• $h')),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
