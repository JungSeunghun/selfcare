class Emotion {
  final int? id;
  final String emotionType; // 감정 타입
  final int intensity; // 강도
  final String date; // 날짜

  Emotion({
    this.id,
    required this.emotionType,
    required this.intensity,
    required this.date,
  });

  /// 데이터베이스에서 맵으로 변환
  factory Emotion.fromMap(Map<String, dynamic> map) {
    return Emotion(
      id: map['id'],
      emotionType: map['emotionType'],
      intensity: map['intensity'],
      date: map['date'],
    );
  }

  /// 객체를 데이터베이스 맵으로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emotionType': emotionType,
      'intensity': intensity,
      'date': date,
    };
  }

  /// `copyWith` 메서드
  Emotion copyWith({
    int? id,
    String? emotionType,
    int? intensity,
    String? date,
  }) {
    return Emotion(
      id: id ?? this.id,
      emotionType: emotionType ?? this.emotionType,
      intensity: intensity ?? this.intensity,
      date: date ?? this.date,
    );
  }
}
