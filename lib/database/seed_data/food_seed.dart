import 'package:sqflite/sqflite.dart';

class FoodSeed {
  static Future<void> insertDefaultData(Database db) async {
    const defaultFoodTypes = {
      'en': ['Fruits', 'Vegetables', 'Meat', 'Seafood', 'Dairy', 'Grains', 'Sweets'],
      'ko': ['과일', '채소', '고기', '해산물', '유제품', '곡물', '디저트'],
    };

    for (var locale in defaultFoodTypes.keys) {
      for (var type in defaultFoodTypes[locale]!) {
        await db.insert('food_types', {'name': type, 'locale': locale});
      }
    }
  }
}
