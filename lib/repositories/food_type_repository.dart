import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/food_type_model.dart';

class FoodTypeRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// 모든 음식 유형 가져오기
  Future<List<FoodTypeModel>> getFoodTypes(String locale) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'food_types',
      where: 'locale = ?',
      whereArgs: [locale],
    );
    return List.generate(
      maps.length,
          (i) => FoodTypeModel.fromMap(maps[i]),
    );
  }

  /// 음식 유형 추가
  Future<void> addFoodType(FoodTypeModel foodType) async {
    final db = await _dbHelper.database;
    await db.insert(
      'food_types',
      foodType.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 음식 유형 업데이트
  Future<void> updateFoodType(FoodTypeModel foodType) async {
    final db = await _dbHelper.database;
    await db.update(
      'food_types',
      foodType.toMap(),
      where: 'id = ?',
      whereArgs: [foodType.id],
    );
  }

  /// 음식 유형 삭제
  Future<void> deleteFoodType(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'food_types',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
