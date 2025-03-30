import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitTile extends StatefulWidget {
  final Habit habit;

  HabitTile({required this.habit});

  @override
  _HabitTileState createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  void _toggleToday() {
    final today = DateTime.now();
    setState(() {
      widget.habit.toggleComplete(DateTime(today.year, today.month, today.day));
    });
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final isCompleted = widget.habit.completedDates.contains(today);

    return ListTile(
      leading: Text(widget.habit.icon, style: TextStyle(fontSize: 24)),
      title: Text(widget.habit.title),
      trailing: IconButton(
        icon: Icon(isCompleted ? Icons.check_circle : Icons.circle_outlined,
            color: isCompleted ? Colors.green : Colors.grey),
        onPressed: _toggleToday,
      ),
    );
  }
}
