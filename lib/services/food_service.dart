import '../models/food_model.dart';
import '../repositories/food_repository.dart';

class FoodService {
  final FoodRepository _foodRepository = FoodRepository();

  /// 🍽️ 특정 날짜의 음식 데이터 가져오기
  Future<List<FoodModel>> getFoodsByDate(String date) async {
    try {
      return await _foodRepository.getFoodsByDate(date);
    } catch (e) {
      print('Error fetching food data: $e');
      return [];
    }
  }

  // 🍽️ 음식 데이터 저장 (리스트 형태로 한 번에 저장)
  Future<List<FoodModel>> saveFoodList(List<FoodModel> foodList) async {
    List<FoodModel> savedFoods = [];

    for (var food in foodList) {
      if (food.id == null) {
        // 새 음식 기록 추가
        final newFood = await _foodRepository.addFood(food);
        savedFoods.add(newFood);
      } else {
        // 기존 음식 기록 업데이트
        await _foodRepository.updateFood(food);
        savedFoods.add(food);
      }
    }

    // 저장된 데이터 반환
    return savedFoods;
  }


  /// ➕ 음식 데이터 추가
  Future<void> addFood(FoodModel food) async {
    try {
      await _foodRepository.addFood(food);
    } catch (e) {
      print('Error adding food: $e');
    }
  }

  /// ✏️ 음식 데이터 업데이트
  Future<void> updateFood(FoodModel food) async {
    try {
      await _foodRepository.updateFood(food);
    } catch (e) {
      print('Error updating food: $e');
    }
  }

  /// ❌ 음식 데이터 삭제
  Future<void> deleteFood(int id) async {
    try {
      await _foodRepository.deleteFood(id);
    } catch (e) {
      print('Error deleting food: $e');
    }
  }
}
