import 'package:sqflite/sqflite.dart';

class WorkoutSeed {
  static Future<void> insertDefaultData(Database db) async {
    const defaultTypes = {
      'en': ['Running', 'Cycling', 'Yoga', 'Weight Training', 'Swimming', 'Tennis', 'Pilates', 'Soccer', 'Basketball'],
      'ko': ['러닝', '자전거 타기', '요가', '웨이트 트레이닝', '수영', '테니스', '필라테스', '축구', '농구'],
    };

    for (var locale in defaultTypes.keys) {
      for (var type in defaultTypes[locale]!) {
        await db.insert('workout_types', {'name': type, 'locale': locale});
      }
    }
  }
}
