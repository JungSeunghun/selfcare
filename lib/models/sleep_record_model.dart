class SleepRecord {
  final int? id;
  final String date;
  final String sleepTime;
  final String wakeTime;
  final String totalSleepDuration;

  SleepRecord({
    this.id,
    required this.date,
    required this.sleepTime,
    required this.wakeTime,
    required this.totalSleepDuration,
  });

  factory SleepRecord.fromMap(Map<String, dynamic> map) {
    return SleepRecord(
      id: map['id'],
      date: map['date'] ?? '-',
      sleepTime: map['sleepTime'] ?? '-',
      wakeTime: map['wakeTime'] ?? '-',
      totalSleepDuration: map['totalSleepDuration'] ?? '-',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'sleepTime': sleepTime,
      'wakeTime': wakeTime,
      'totalSleepDuration': totalSleepDuration,
    };
  }

  /// `copyWith` 메서드
  SleepRecord copyWith({
    int? id,
    String? date,
    String? sleepTime,
    String? wakeTime,
    String? totalSleepDuration,
  }) {
    return SleepRecord(
      id: id ?? this.id,
      date: date ?? this.date,
      sleepTime: sleepTime ?? this.sleepTime,
      wakeTime: wakeTime ?? this.wakeTime,
      totalSleepDuration: totalSleepDuration ?? this.totalSleepDuration,
    );
  }
}
