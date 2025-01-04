import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/workout_type_model.dart';

class WorkoutTypeRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// 📋 모든 운동 타입 가져오기
  Future<List<WorkoutType>> getWorkoutTypesByLocale(String locale) async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query(
        'workout_types',
        where: 'locale = ?',
        whereArgs: [locale],
      );
      return WorkoutType.fromList(result);
    } catch (e) {
      print('Error fetching workout types: $e');
      return [];
    }
  }

  /// ➕ 운동 타입 추가
  Future<void> addWorkoutType(String name, String locale) async {
    try {
      final db = await _dbHelper.database;
      await db.insert(
        'workout_types',
        {'name': name, 'locale': locale},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (e) {
      print('Error adding workout type: $e');
    }
  }

  /// 🔍 운동 타입 존재 여부 확인
  Future<bool> workoutTypeExists(String name) async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query(
        'workout_types',
        where: 'name = ?',
        whereArgs: [name],
      );
      return result.isNotEmpty;
    } catch (e) {
      print('Error checking workout type existence: $e');
      return false;
    }
  }

  /// ✏️ 운동 타입 업데이트
  Future<void> updateWorkoutType(WorkoutType workoutType) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        'workout_types',
        {'name': workoutType.name},
        where: 'id = ?',
        whereArgs: [workoutType.id],
      );
    } catch (e) {
      print('Error updating workout type: $e');
    }
  }

  /// ❌ 운동 타입 삭제
  Future<void> deleteWorkoutType(int id) async {
    try {
      final db = await _dbHelper.database;
      await db.delete(
        'workout_types',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting workout type: $e');
    }
  }
}
