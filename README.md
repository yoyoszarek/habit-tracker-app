# habit tracker app

A new Flutter project to practice different items + folders.

------------------------------------
- Features & Structure
Main Screen: Habit list with checkboxes, heatmap calendar, and floating action button.

Drawer: Toggle for light/dark mode (with SharedPreferences).

Habit Tiles: Slidable cards for edit/delete with completion toggle.

Heatmap: Visualizes habit streaks using flutter_heatmap_calendar.

- Logic & Persistence
HabitDatabase: CRUD operations with Isar DB; syncs UI via ChangeNotifier.

AppSettings: Stores first app launch date.

ThemeProvider: Manages app theming (light/dark).

- Utilities
SharedPreferences: Persist theme toggle & custom flags.

Helper Functions: Check if habit completed today, prep heatmap data.

- Tech Stack
Flutter

Isar for local database

Provider for state management

SharedPreferences

flutter_slidable for swipe actions

flutter_heatmap_calendar for visual stats
