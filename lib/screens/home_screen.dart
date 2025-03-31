import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';
import '../widgets/habit_tile.dart';
import 'add_habit_screen.dart';
import 'calendar_all_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HabitService _habitService = HabitService();

  @override
  void initState() {
    super.initState();
    _habitService.loadHabits().then((_) {
      setState(() {});
    });
  }

  void _addHabit() async {
    final Habit? newHabit = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddHabitScreen()),
    );
    if (newHabit != null) {
      await _habitService.addHabit(newHabit);
      setState(() {});
    }
  }

  void _toggleToday(Habit habit) async {
    await _habitService.toggleCompletion(habit, DateTime.now());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final habits = _habitService.getHabits();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Habits"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CalendarAllScreen(allHabits: habits),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addHabit,
          ),
        ],
      ),
      body: habits.isEmpty
          ? Center(child: Text("No habits yet. Tap + to add one."))
          : ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                // Monthly Progress Bars
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: habits.map((habit) {
                      final now = DateTime.now();
                      final completedThisMonth = habit.completedDates
                          .where((d) => d.year == now.year && d.month == now.month)
                          .length;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${habit.title} - $completedThisMonth days | 🔥 Streak: ${habit.getCurrentStreak()}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            LinearProgressIndicator(
                              value: completedThisMonth / 30,
                              backgroundColor: Colors.grey[300],
                              color: Colors.deepPurple,
                              minHeight: 6,
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Habit List (no calendars)
                ...habits.map((habit) => Column(
                      children: [
                        HabitTile(
                          habit: habit,
                          onToggle: () => _toggleToday(habit),
                        ),
                        Divider(),
                      ],
                    )),
              ],
            ),
    );
  }
}
