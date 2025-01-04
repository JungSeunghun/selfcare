import 'package:sqflite/sqflite.dart';

class WorkoutTable {
  static Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutType TEXT,
        duration INTEGER,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE workout_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        locale TEXT NOT NULL
      )
    ''');
  }
}
