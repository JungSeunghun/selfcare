import '../models/emotion_type_model.dart';
import '../repositories/emotion_type_repository.dart';

class EmotionTypeService {
  final EmotionTypeRepository _emotionTypeRepository = EmotionTypeRepository();

  /// 📋 모든 감정 타입 가져오기
  Future<List<EmotionType>> getEmotionTypes(String locale) async {
    try {
      return await _emotionTypeRepository.getAllEmotionTypes(locale);
    } catch (e) {
      print('Error fetching emotion types: $e');
      return [];
    }
  }

  /// ➕ 새로운 감정 유형 추가
  Future<void> addEmotionType(String name, String locale) async {
    try {
      final exists = await _emotionTypeRepository.emotionTypeExists(name, locale);
      if (!exists) {
        await _emotionTypeRepository.addEmotionType(name, locale);
      } else {
        print("Emotion type already exists.");
      }
    } catch (e) {
      print("Error adding emotion type: $e");
    }
  }

  /// ✏️ 감정 타입 업데이트
  Future<void> updateEmotionType(EmotionType emotionType) async {
    try {
      await _emotionTypeRepository.updateEmotionType(emotionType);
    } catch (e) {
      print('Error updating emotion type: $e');
    }
  }

  /// ❌ 감정 타입 삭제
  Future<void> deleteEmotionType(int id) async {
    try {
      await _emotionTypeRepository.deleteEmotionType(id);
    } catch (e) {
      print('Error deleting emotion type: $e');
    }
  }
}
