import '../models/workout_record_model.dart';
import '../database/database_helper.dart';

class WorkoutRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// 날짜별 운동 기록 가져오기
  Future<List<WorkoutRecord>> getWorkoutsByDate(String date) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'workouts',
      where: 'date = ?',
      whereArgs: [date],
    );
    return result.map((record) => WorkoutRecord.fromMap(record)).toList();
  }

  /// 운동 기록 삽입
  Future<int> insertWorkout(WorkoutRecord record) async {
    final db = await _dbHelper.database;
    return await db.insert('workouts', record.toMap());
  }

  /// 운동 기록 수정
  Future<int> updateWorkout(WorkoutRecord record) async {
    final db = await _dbHelper.database;
    return await db.update(
      'workouts',
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  /// 운동 기록 삭제
  Future<int> deleteWorkout(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 운동 기록 저장 (삽입 또는 수정)
  Future<int> saveWorkoutRecord(WorkoutRecord record) async {
    if (record.id != null) {
      return await updateWorkout(record);
    } else {
      return await insertWorkout(record);
    }
  }
}
