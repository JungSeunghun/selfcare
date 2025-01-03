import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/workout_type_model.dart';

class WorkoutTypeRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// 📋 Fetch all workout types
  Future<List<WorkoutType>> getAllWorkoutTypes() async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query('workout_types');
      return WorkoutType.fromList(result);
    } catch (e) {
      print('Error fetching workout types: $e');
      return [];
    }
  }

  /// ➕ Add a new workout type
  Future<void> addWorkoutType(String name) async {
    try {
      final db = await _dbHelper.database;
      await db.insert(
        'workout_types',
        {'name': name},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (e) {
      print('Error adding workout type: $e');
    }
  }

  /// ✏️ Update an existing workout type
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

  /// ❌ Delete a workout type by ID
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

  /// 🔍 Check if a workout type exists
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
}
