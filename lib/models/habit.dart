class Habit {
  final String title;
  final String icon;
  List<DateTime> completedDates; // Make it mutable

  Habit({
    required this.title,
    required this.icon,
    List<DateTime>? completedDates,
  }) : completedDates = List.from(completedDates ?? []); // ✅ Make a mutable copy

  void toggleComplete(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    if (completedDates.any((d) => _isSameDay(d, dateOnly))) {
      completedDates.removeWhere((d) => _isSameDay(d, dateOnly));
    } else {
      completedDates.add(dateOnly);
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
