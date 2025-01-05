class IncomeExpenseTypeModel {
  int? id;
  String name;
  String locale;
  String category; // 'income' or 'expense'

  IncomeExpenseTypeModel({
    this.id,
    required this.name,
    required this.locale,
    required this.category,
  });

  // 데이터베이스에서 객체로 변환
  factory IncomeExpenseTypeModel.fromMap(Map<String, dynamic> map) {
    return IncomeExpenseTypeModel(
      id: map['id'],
      name: map['name'],
      locale: map['locale'],
      category: map['category'],
    );
  }

  // 객체를 데이터베이스에 삽입할 수 있도록 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'locale': locale,
      'category': category,
    };
  }

  // copyWith 메서드 추가
  IncomeExpenseTypeModel copyWith({
    int? id,
    String? name,
    String? locale,
    String? category,
  }) {
    return IncomeExpenseTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      locale: locale ?? this.locale,
      category: category ?? this.category,
    );
  }
}
