import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/food_model.dart';

class FoodRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// 🍽️ 특정 날짜의 음식 데이터 가져오기
  Future<List<FoodModel>> getFoodsByDate(String date) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'foods',
      where: 'date = ?',
      whereArgs: [date],
    );
    return result.map((map) => FoodModel.fromMap(map)).toList();
  }

  /// ➕ 음식 데이터 추가
  Future<void> addFood(FoodModel food) async {
    final db = await _dbHelper.database;
    await db.insert('foods', food.toMap());
  }

  /// ✏️ 음식 데이터 업데이트
  Future<void> updateFood(FoodModel food) async {
    final db = await _dbHelper.database;
    await db.update(
      'foods',
      food.toMap(),
      where: 'id = ?',
      whereArgs: [food.id],
    );
  }

  /// ❌ 음식 데이터 삭제
  Future<void> deleteFood(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'foods',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
