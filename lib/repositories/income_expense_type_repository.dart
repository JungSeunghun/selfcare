import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/income_expense_type_model.dart';

class IncomeExpenseTypeRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// 📋 모든 수입/지출 타입 가져오기
  Future<List<IncomeExpenseTypeModel>> getIncomeExpenseTypesByLocale(String locale) async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query(
        'income_expense_types',
        where: 'locale = ?',
        whereArgs: [locale],
      );
      return result.map((map) => IncomeExpenseTypeModel.fromMap(map)).toList();
    } catch (e) {
      print('Error fetching income/expense types: $e');
      return [];
    }
  }

  /// ➕ 수입/지출 타입 추가
  Future<void> addIncomeExpenseType(String name, String locale, String category) async {
    try {
      final db = await _dbHelper.database;
      await db.insert(
        'income_expense_types',
        {'name': name, 'locale': locale, 'category': category},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (e) {
      print('Error adding income/expense type: $e');
    }
  }

  /// 🔍 수입/지출 타입 존재 여부 확인
  Future<bool> incomeExpenseTypeExists(String name) async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query(
        'income_expense_types',
        where: 'name = ?',
        whereArgs: [name],
      );
      return result.isNotEmpty;
    } catch (e) {
      print('Error checking income/expense type existence: $e');
      return false;
    }
  }

  /// ✏️ 수입/지출 타입 업데이트
  Future<void> updateIncomeExpenseType(IncomeExpenseTypeModel type) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        'income_expense_types',
        {
          'name': type.name,
          'locale': type.locale,
          'category': type.category,
        },
        where: 'id = ?',
        whereArgs: [type.id],
      );
    } catch (e) {
      print('Error updating income/expense type: $e');
    }
  }

  /// ❌ 수입/지출 타입 삭제
  Future<void> deleteIncomeExpenseType(int id) async {
    try {
      final db = await _dbHelper.database;
      await db.delete(
        'income_expense_types',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting income/expense type: $e');
    }
  }
}
