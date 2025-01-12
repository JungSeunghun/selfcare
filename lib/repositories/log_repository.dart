import '../models/log_record_model.dart';
import '../database/database_helper.dart';

class LogRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<LogRecord> getLogRecordByDate(String date) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'log',
      where: 'date = ?',
      whereArgs: [date],
      limit: 1, // Fetch only one record
    );
    if (result.isNotEmpty) {
      return LogRecord.fromMap(result.first);
    }
    return LogRecord(
      id: null,
      date: date,
      note: "",
    );
  }

  Future<int> saveLogRecord(LogRecord record) async {
    final db = await _dbHelper.database;
    if (record.id != null) {
      return await updateLogRecord(record); // Update if ID exists
    } else {
      return await db.insert('log', record.toMap()); // Insert if new
    }
  }

  Future<int> updateLogRecord(LogRecord record) async {
    final db = await _dbHelper.database;
    return await db.update(
      'log',
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }
}
