import '../models/emotion_model.dart';
import '../repositories/emotion_repository.dart';

class EmotionService {
  final EmotionRepository _emotionRepository = EmotionRepository();

  /// 📋 모든 감정 기록 가져오기
  Future<List<Emotion>> getAllEmotions() async {
    return await _emotionRepository.getAllEmotions();
  }

  /// 🔍 날짜별 감정 데이터 가져오기
  Future<List<Emotion>> getEmotionsByDate(String date) async {
    try {
      return await _emotionRepository.getEmotionsByDate(date);
    } catch (e) {
      print("Error fetching emotions by date: $e");
      return [];
    }
  }

  /// ➕ 감정 데이터 저장 (리스트 형태로 한 번에 저장)
  Future<List<Emotion>> saveEmotionList(List<Emotion> emotions) async {
    List<Emotion> savedEmotions = [];

    for (var emotion in emotions) {
      if (emotion.id == null) {
        // 새 감정 데이터 삽입
        final newEmotion = await _emotionRepository.insertEmotion(emotion);
        savedEmotions.add(newEmotion);
      } else {
        // 기존 감정 데이터 업데이트
        await _emotionRepository.updateEmotion(emotion);
        savedEmotions.add(emotion);
      }
    }

    return savedEmotions;
  }

  /// ✏️ 감정 기록 업데이트
  Future<void> updateEmotion(Emotion emotion) async {
    await _emotionRepository.updateEmotion(emotion);
  }

  /// ❌ 감정 기록 삭제
  Future<void> deleteEmotion(int id) async {
    await _emotionRepository.deleteEmotion(id);
  }
}
