import '../models/habit.dart';

class HabitService {
  List<Habit> habits = [];

  List<Habit> getHabits() => habits;

  void addHabit(Habit habit) {
    habits.add(habit);
  }

  void removeHabit(Habit habit) {
    habits.remove(habit);
  }
}
