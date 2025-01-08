class FoodModel {
  final int? id;
  final String foodName;
  final String foodType; // 텍스트 타입
  final String date;
  final String mealType;

  FoodModel({
    this.id,
    required this.foodName,
    required this.foodType,
    required this.date,
    required this.mealType,
  });

  // 📦 맵으로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foodName': foodName,
      'foodType': foodType,
      'date': date,
      'mealType': mealType,
    };
  }

  // 🗄️ 맵에서 객체로 변환
  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      foodName: map['foodName'],
      foodType: map['foodType'],
      date: map['date'],
      mealType: map['mealType'],
    );
  }

  // 🛠️ copyWith 메서드 추가
  FoodModel copyWith({
    int? id,
    String? foodName,
    String? foodType,
    String? date,
    String? mealType,
  }) {
    return FoodModel(
      id: id ?? this.id,
      foodName: foodName ?? this.foodName,
      foodType: foodType ?? this.foodType,
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
    );
  }

  // 📝 리스트 변환 메서드
  static List<FoodModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => FoodModel.fromMap(map)).toList();
  }
}
