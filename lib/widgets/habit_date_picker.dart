import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:intl/intl.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';

class HabitDatePicker extends StatefulWidget {
  final Habit habit;
  final VoidCallback onChange;

  HabitDatePicker({required this.habit, required this.onChange});

  @override
  _HabitDatePickerState createState() => _HabitDatePickerState();
}

class _HabitDatePickerState extends State<HabitDatePicker> {
  final HabitService _habitService = HabitService();

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _toggleDay(DateTime day) async {
    widget.habit.toggleComplete(day);
    await _habitService.saveHabits();
    widget.onChange();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarCarousel(
      onDayPressed: (date, _) {
        _toggleDay(date);
        setState(() {});
      },
      weekendTextStyle: TextStyle(color: Colors.red),
      weekdayTextStyle: TextStyle(color: Colors.black),
      thisMonthDayBorderColor: Colors.grey,
      selectedDayButtonColor: Colors.green,
      selectedDayTextStyle: TextStyle(color: Colors.white),
      customDayBuilder: (
        bool isSelectable,
        int index,
        bool isSelectedDay,
        bool isToday,
        bool isPrevMonthDay,
        TextStyle textStyle,
        bool isNextMonthDay,
        bool isThisMonthDay,
        DateTime day,
      ) {
        final isDone = widget.habit.completedDates.any((d) => _isSameDay(d, day));

        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: isDone ? Colors.green : null,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: isDone ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      },
      showOnlyCurrentMonthDate: false,
      height: 160.0,
      daysHaveCircularBorder: true,
      markedDateShowIcon: false,
      markedDateMoreShowTotal: false,
      weekFormat: true,
      isScrollable: true,
      headerText: DateFormat('MMMM yyyy').format(DateTime.now()),
      leftButtonIcon: Icon(Icons.arrow_back_ios, size: 14),
      rightButtonIcon: Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}
