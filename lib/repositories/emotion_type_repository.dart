import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/emotion_type_model.dart';

class EmotionTypeRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// 📋 모든 감정 타입 가져오기
  Future<List<EmotionType>> getAllEmotionTypes(String locale) async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query(
        'emotion_types',
        where: 'locale = ?',
        whereArgs: [locale],
      );
      return result.map((map) => EmotionType.fromMap(map)).toList();
    } catch (e) {
      print('Error fetching emotion types: $e');
      return [];
    }
  }

  /// 🔍 감정 유형 존재 여부 확인
  Future<bool> emotionTypeExists(String name, String locale) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'emotion_types',
      where: 'name = ? AND locale = ?',
      whereArgs: [name, locale],
    );
    return result.isNotEmpty;
  }

  /// ➕ 새로운 감정 유형 추가
  Future<void> addEmotionType(String name, String locale) async {
    final db = await _dbHelper.database;
    await db.insert(
      'emotion_types',
      {
        'name': name,
        'locale': locale,
      },
    );
  }

  /// ✏️ 감정 타입 업데이트
  Future<void> updateEmotionType(EmotionType emotionType) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        'emotion_types',
        emotionType.toMap(),
        where: 'id = ?',
        whereArgs: [emotionType.id],
      );
    } catch (e) {
      print('Error updating emotion type: $e');
    }
  }

  /// ❌ 감정 타입 삭제
  Future<void> deleteEmotionType(int id) async {
    try {
      final db = await _dbHelper.database;
      await db.delete(
        'emotion_types',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting emotion type: $e');
    }
  }
}
