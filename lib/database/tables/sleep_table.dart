import 'package:sqflite/sqflite.dart';

class SleepTable {
  static Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE sleep (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sleepTime TEXT,
        wakeTime TEXT,
        totalSleepDuration TEXT,
        date TEXT
      )
    ''');
  }
}
