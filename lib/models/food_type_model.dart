class FoodTypeModel {
  final int? id;
  final String name;
  final String locale;

  FoodTypeModel({
    this.id,
    required this.name,
    required this.locale,
  });

  // 📦 맵으로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'locale': locale,
    };
  }

  // 🗄️ 맵에서 객체로 변환
  factory FoodTypeModel.fromMap(Map<String, dynamic> map) {
    return FoodTypeModel(
      id: map['id'],
      name: map['name'],
      locale: map['locale'],
    );
  }

  // 🛠️ copyWith 메서드 추가
  FoodTypeModel copyWith({
    int? id,
    String? name,
    String? locale,
  }) {
    return FoodTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      locale: locale ?? this.locale,
    );
  }

  // 📝 리스트 변환 메서드
  static List<FoodTypeModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => FoodTypeModel.fromMap(map)).toList();
  }
}
