import '../models/sleep_record_model.dart';
import '../database/database_helper.dart';

class SleepRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<SleepRecord> getSleepRecordByDate(String date) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'sleep',
      where: 'date = ?',
      whereArgs: [date],
      limit: 1, // Fetch only one record
    );
    if (result.isNotEmpty) {
      return SleepRecord.fromMap(result.first);
    }
    return SleepRecord(
      id: null,
      date: date,
      sleepTime: "22:00",
      wakeTime: "07:00",
      totalSleepDuration: "0시간 0분",
    );
  }

  Future<int> saveSleepRecord(SleepRecord record) async {
    final db = await _dbHelper.database;
    if (record.id != null) {
      return await updateSleepRecord(record); // Update if ID exists
    } else {
      return await db.insert('sleep', record.toMap()); // Insert if new
    }
  }

  Future<int> updateSleepRecord(SleepRecord record) async {
    final db = await _dbHelper.database;
    return await db.update(
      'sleep',
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }
}
