import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';
import '../widgets/habit_tile.dart';
import 'add_habit_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HabitService _habitService = HabitService();

  void _addHabit() async {
    final Habit? newHabit = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddHabitScreen()),
    );
    if (newHabit != null) {
      setState(() => _habitService.addHabit(newHabit));
    }
  }

  @override
  Widget build(BuildContext context) {
    final habits = _habitService.getHabits();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Habits"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addHabit,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return HabitTile(habit: habits[index]);
        },
      ),
    );
  }
}
