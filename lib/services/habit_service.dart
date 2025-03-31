import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habit.dart';

class HabitService {
  List<Habit> _habits = [];

  Future<void> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('habits');
    if (data != null) {
      final jsonList = jsonDecode(data) as List;
      _habits = jsonList.map((e) => Habit.fromJson(e)).toList();
    }
  }

  Future<void> saveHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_habits.map((h) => h.toJson()).toList());
    await prefs.setString('habits', data);
  }

  List<Habit> getHabits() => _habits;

  Future<void> addHabit(Habit habit) async {
    _habits.add(habit);
    await saveHabits();
  }

  Future<void> toggleCompletion(Habit habit, DateTime date) async {
    habit.toggleComplete(date);
    await saveHabits();
  }
}
