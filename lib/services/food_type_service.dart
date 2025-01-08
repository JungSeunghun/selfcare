import '../models/food_type_model.dart';
import '../repositories/food_type_repository.dart';

class FoodTypeService {
  final FoodTypeRepository _foodTypeRepository = FoodTypeRepository();

  /// 로케일에 따라 음식 유형 가져오기
  Future<List<FoodTypeModel>> getFoodTypes(String locale) async {
    try {
      return await _foodTypeRepository.getFoodTypes(locale);
    } catch (e) {
      print('Error fetching food types: $e');
      return [];
    }
  }

  /// 음식 유형 추가
  Future<void> addFoodType(String name, String locale) async {
    try {
      await _foodTypeRepository.addFoodType(
        FoodTypeModel(name: name, locale: locale),
      );
    } catch (e) {
      print('Error adding food type: $e');
    }
  }

  /// 음식 유형 업데이트
  Future<void> updateFoodType(FoodTypeModel foodType) async {
    try {
      await _foodTypeRepository.updateFoodType(foodType);
    } catch (e) {
      print('Error updating food type: $e');
    }
  }

  /// 음식 유형 삭제
  Future<void> deleteFoodType(int id) async {
    try {
      await _foodTypeRepository.deleteFoodType(id);
    } catch (e) {
      print('Error deleting food type: $e');
    }
  }
}
