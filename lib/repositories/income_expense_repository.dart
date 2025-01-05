import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/income_expense_model.dart';

class IncomeExpenseRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// 📋 모든 수입/지출 데이터 가져오기
  Future<List<IncomeExpenseModel>> getAllIncomeExpenses() async {
    final db = await _dbHelper.database;
    final result = await db.query('income_expense');
    return result.map((map) => IncomeExpenseModel.fromMap(map)).toList();
  }

  /// 🔍 날짜별 수입/지출 데이터 가져오기
  Future<List<IncomeExpenseModel>> getIncomeExpensesByDate(String date) async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query(
        'income_expense',
        where: 'date = ?',
        whereArgs: [date],
      );
      return result.map((map) => IncomeExpenseModel.fromMap(map)).toList();
    } catch (e) {
      print('Error fetching income/expenses by date: $e');
      return [];
    }
  }

  /// ➕ 수입/지출 데이터 삽입
  Future<IncomeExpenseModel> insertIncomeExpense(IncomeExpenseModel incomeExpense) async {
    final db = await _dbHelper.database;
    final id = await db.insert('income_expense', incomeExpense.toMap());
    return incomeExpense.copyWith(id: id);
  }

  /// ✏️ 수입/지출 데이터 업데이트
  Future<void> updateIncomeExpense(IncomeExpenseModel incomeExpense) async {
    final db = await _dbHelper.database;
    await db.update(
      'income_expense',
      incomeExpense.toMap(),
      where: 'id = ?',
      whereArgs: [incomeExpense.id],
    );
  }

  /// ❌ 수입/지출 데이터 삭제
  Future<void> deleteIncomeExpense(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'income_expense',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
