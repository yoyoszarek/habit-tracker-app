import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../screens/calendar_screen.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;

  HabitTile({required this.habit, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final isCompleted = habit.completedDates.any(
      (d) => d.year == todayOnly.year && d.month == todayOnly.month && d.day == todayOnly.day,
    );

    return ListTile(
      leading: Text(habit.icon, style: TextStyle(fontSize: 24)),
      title: Text(habit.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CalendarScreen(habit: habit),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(isCompleted ? Icons.check_circle : Icons.circle_outlined),
            onPressed: onToggle,
          ),
        ],
      ),
    );
  }
}
