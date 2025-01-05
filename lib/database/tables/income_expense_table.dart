import 'package:sqflite/sqflite.dart';

class IncomeExpenseTypeTable {
  static Future<void> create(Database db) async {
    // 수입/지출 데이터 테이블 생성
    await db.execute('''
      CREATE TABLE income_expense (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,  -- 'income' 또는 'expense'
        amount REAL NOT NULL,
        description TEXT,
        date TEXT NOT NULL,
        typeId INTEGER,
        FOREIGN KEY (typeId) REFERENCES income_expense_types (id)
      )
    ''');

    // 수입/지출 타입 테이블 생성
    await db.execute('''
      CREATE TABLE income_expense_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        locale TEXT NOT NULL,
        category TEXT NOT NULL  -- 'income' 또는 'expense'로 카테고리 구분
      )
    ''');
  }
}
