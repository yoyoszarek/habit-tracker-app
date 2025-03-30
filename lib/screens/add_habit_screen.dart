import 'package:flutter/material.dart';
import '../models/habit.dart';

class AddHabitScreen extends StatefulWidget {
  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _titleController = TextEditingController();
  String _selectedIcon = '🔥';

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isNotEmpty) {
      final habit = Habit(title: title, icon: _selectedIcon);
      Navigator.pop(context, habit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Habit")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Habit Title')),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedIcon,
              items: ['🔥', '💪', '📚', '🧘‍♀️', '🥦']
                  .map((e) => DropdownMenuItem(child: Text(e, style: TextStyle(fontSize: 24)), value: e))
                  .toList(),
              onChanged: (value) => setState(() => _selectedIcon = value!),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text("Add Habit"))
          ],
        ),
      ),
    );
  }
}
