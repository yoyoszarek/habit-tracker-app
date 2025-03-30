import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() => runApp(HabitTrackerApp());

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: LoginScreen(), // ✅ no MyHomePage here!
      debugShowCheckedModeBanner: false,
    );
  }
}
