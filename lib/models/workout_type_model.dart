class WorkoutType {
  final int? id; // Primary key (nullable for new entries)
  final String name; // Workout type name

  WorkoutType({this.id, required this.name});

  // Convert a WorkoutType object to a map (for inserting into the database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Create a WorkoutType object from a map (retrieved from the database)
  factory WorkoutType.fromMap(Map<String, dynamic> map) {
    return WorkoutType(
      id: map['id'],
      name: map['name'],
    );
  }

  // Convert a list of maps to a list of WorkoutType objects
  static List<WorkoutType> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => WorkoutType.fromMap(map)).toList();
  }
}
