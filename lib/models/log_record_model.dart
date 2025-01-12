class LogRecord {
  final int? id;
  final String note;
  final String date;

  LogRecord({
    this.id,
    required this.note,
    required this.date,
  });

  // Convert a LogRecord object to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note': note,
      'date': date,
    };
  }

  // Convert a Map from the database to a LogRecord object
  factory LogRecord.fromMap(Map<String, dynamic> map) {
    return LogRecord(
      id: map['id'],
      note: map['note'],
      date: map['date'],
    );
  }
}