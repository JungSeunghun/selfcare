import 'package:sqflite/sqflite.dart';

class FoodTable {
  static Future<void> create(Database db) async {
    // food_types 테이블 생성
    await db.execute('''
      CREATE TABLE food_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        locale TEXT NOT NULL
      )
    ''');

    // foods 테이블 생성 (foodTypeId 제거, foodType 추가)
    await db.execute('''
      CREATE TABLE foods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        foodName TEXT NOT NULL,
        foodType TEXT NOT NULL,
        date TEXT NOT NULL,
        mealType TEXT NOT NULL
      )
    ''');
  }
}
