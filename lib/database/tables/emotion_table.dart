import 'package:sqflite/sqflite.dart';

class EmotionTable {
  static Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE emotion_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        locale TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE emotions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        emotionTypeId INTEGER NOT NULL,
        intensity INTEGER NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (emotionTypeId) REFERENCES emotion_types (id)
      )
    ''');
  }
}
