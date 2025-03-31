class Habit {
  final String title;
  final String icon;
  List<DateTime> completedDates;

  Habit({
    required this.title,
    required this.icon,
    List<DateTime>? completedDates,
  }) : completedDates = List.from(completedDates ?? []);

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

  int getCurrentStreak() {
    final today = DateTime.now();
    int streak = 0;
    for (int i = 0;; i++) {
      final day = DateTime(today.year, today.month, today.day).subtract(Duration(days: i));
      if (completedDates.any((d) => _isSameDay(d, day))) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'icon': icon,
        'completedDates': completedDates.map((d) => d.toIso8601String()).toList(),
      };

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
        title: json['title'],
        icon: json['icon'],
        completedDates: (json['completedDates'] as List)
            .map((e) => DateTime.parse(e))
            .toList(),
      );
}
