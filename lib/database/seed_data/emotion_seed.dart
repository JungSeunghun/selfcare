import 'package:sqflite/sqflite.dart';

class EmotionSeed {
  static Future<void> insertDefaultData(Database db) async {
    const defaultEmotions = {
      'en': ['Happy', 'Sad', 'Angry', 'Anxious', 'Excited'],
      'ko': ['행복', '슬픔', '분노', '불안', '기쁨'],
    };

    for (var locale in defaultEmotions.keys) {
      for (var emotion in defaultEmotions[locale]!) {
        await db.insert('emotion_types', {'name': emotion, 'locale': locale});
      }
    }
  }
}
