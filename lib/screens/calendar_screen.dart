import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';

class CalendarScreen extends StatefulWidget {
  final Habit habit;

  CalendarScreen({required this.habit});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final HabitService _habitService = HabitService();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isCompletedOn(DateTime day) {
    return widget.habit.completedDates.any(
      (d) => d.year == day.year && d.month == day.month && d.day == day.day,
    );
  }

  void _toggleDay(DateTime day) async {
    setState(() {
      widget.habit.toggleComplete(day);
    });
    await _habitService.saveHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.habit.title} Calendar")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) =>
                _selectedDay != null &&
                day.year == _selectedDay!.year &&
                day.month == _selectedDay!.month &&
                day.day == _selectedDay!.day,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              final wasCompleted = _isCompletedOn(selectedDay);
              final toggleText = wasCompleted ? 'mark as not done' : 'mark as done';

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("${widget.habit.title}"),
                  content: Text(
                    "Do you want to $toggleText for ${selectedDay.month}/${selectedDay.day}/${selectedDay.year}?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        _toggleDay(selectedDay);
                        Navigator.pop(context);
                      },
                      child: Text("Yes"),
                    ),
                  ],
                ),
              );
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                final isComplete = _isCompletedOn(day);
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isComplete ? Colors.green[300] : null,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isComplete ? Colors.white : null,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              selectedBuilder: (context, day, _) {
                final isComplete = _isCompletedOn(day);
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isComplete ? Colors.green[600] : Colors.orange[200],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
