import '../models/log_record_model.dart';
import '../repositories/log_repository.dart';

class LogService {
  final LogRepository _logRepository = LogRepository();

  // Get a log record by date
  Future<LogRecord> getLogRecordByDate(String date) async {
    return await _logRepository.getLogRecordByDate(date);
  }

  // Save a new log record or update an existing one
  Future<int> saveLogRecord(LogRecord record) async {
    return await _logRepository.saveLogRecord(record);
  }

  // Update an existing log record
  Future<int> updateLogRecord(LogRecord record) async {
    return await _logRepository.updateLogRecord(record);
  }
}
