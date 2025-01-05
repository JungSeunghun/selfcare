import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/emotion_model.dart';

class EmotionRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// 📋 모든 감정 기록 가져오기
  Future<List<Emotion>> getAllEmotions() async {
    final db = await _dbHelper.database;
    final result = await db.query('emotions');
    return result.map((map) => Emotion.fromMap(map)).toList();
  }

  /// 🔍 날짜별 감정 데이터 가져오기
  Future<List<Emotion>> getEmotionsByDate(String date) async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query(
        'emotions',
        where: 'date = ?',
        whereArgs: [date],
      );
      return result.map((map) => Emotion.fromMap(map)).toList();
    } catch (e) {
      print('Error fetching emotions by date: $e');
      return [];
    }
  }

  /// ➕ 감정 데이터 삽입
  Future<Emotion> insertEmotion(Emotion emotion) async {
    final db = await _dbHelper.database;
    final id = await db.insert('emotions', emotion.toMap());
    return emotion.copyWith(id: id);
  }

  /// ✏️ 감정 기록 업데이트
  Future<void> updateEmotion(Emotion emotion) async {
    final db = await _dbHelper.database;
    await db.update(
      'emotions',
      emotion.toMap(),
      where: 'id = ?',
      whereArgs: [emotion.id],
    );
  }

  /// ❌ 감정 기록 삭제
  Future<void> deleteEmotion(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'emotions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
