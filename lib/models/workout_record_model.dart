class WorkoutRecord {
  final int? id;
  final String date;
  final String workoutType;
  final int duration;

  WorkoutRecord({
    this.id,
    required this.date,
    required this.workoutType,
    required this.duration,
  });

  /// 🛠 fromMap 메서드 수정
  factory WorkoutRecord.fromMap(Map<String, dynamic> map) {
    return WorkoutRecord(
      id: map['id'] as int?,
      date: map['date'] ?? '',
      workoutType: map['workoutType'] ?? '',
      duration: map['duration'] ?? 0,
    );
  }

  /// 📋 WorkoutRecord 객체를 Map 데이터로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'workoutType': workoutType,
      'duration': duration,
    };
  }

  /// 📋 `copyWith` 메서드
  WorkoutRecord copyWith({
    int? id,
    String? date,
    String? workoutType,
    int? duration,
  }) {
    return WorkoutRecord(
      id: id ?? this.id,
      date: date ?? this.date,
      workoutType: workoutType ?? this.workoutType,
      duration: duration ?? this.duration,
    );
  }
}
