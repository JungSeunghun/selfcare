import 'package:sqflite/sqflite.dart';

class EmotionTable {
  static Future<void> create(Database db) async {
    // emotion_types 테이블 생성
    await db.execute('''
      CREATE TABLE emotion_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        locale TEXT NOT NULL
      )
    ''');

    // emotions 테이블 생성
    await db.execute('''
      CREATE TABLE emotions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        emotionType TEXT NOT NULL,
        intensity INTEGER NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }
}
