class WorkoutType {
  final int? id;
  final String name;
  final String locale;

  WorkoutType({this.id, required this.name, required this.locale});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'locale': locale,
    };
  }

  factory WorkoutType.fromMap(Map<String, dynamic> map) {
    return WorkoutType(
      id: map['id'],
      name: map['name'],
      locale: map['locale'],
    );
  }

  static List<WorkoutType> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => WorkoutType.fromMap(map)).toList();
  }
}
