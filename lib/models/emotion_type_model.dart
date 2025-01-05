class EmotionType {
  final int? id;
  final String name;
  final String locale;

  EmotionType({
    this.id,
    required this.name,
    required this.locale,
  });

  /// 데이터베이스 맵핑 메서드
  factory EmotionType.fromMap(Map<String, dynamic> map) {
    return EmotionType(
      id: map['id'],
      name: map['name'],
      locale: map['locale'],
    );
  }

  /// 객체를 데이터베이스 맵으로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'locale': locale,
    };
  }

  /// `copyWith` 메서드
  EmotionType copyWith({
    int? id,
    String? name,
    String? locale,
  }) {
    return EmotionType(
      id: id ?? this.id,
      name: name ?? this.name,
      locale: locale ?? this.locale,
    );
  }
}
