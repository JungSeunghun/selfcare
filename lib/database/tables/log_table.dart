import 'package:sqflite/sqflite.dart';

class LogTable {
  static Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE log (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        note TEXT,
        date TEXT
      )
    ''');
  }
}
