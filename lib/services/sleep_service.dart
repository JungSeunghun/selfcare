import '../models/sleep_record_model.dart';
import '../repositories/sleep_repository.dart';

class SleepService {
  final SleepRepository _sleepRepository = SleepRepository();

  Future<SleepRecord> getSleepRecordByDate(String date) async {
    return await _sleepRepository.getSleepRecordByDate(date);
  }

  Future<SleepRecord> saveSleepRecord(SleepRecord record) async {
    if (record.id == null) {
      final newId = await _sleepRepository.saveSleepRecord(record);
      return record.copyWith(id: newId);
    } else {
      await _sleepRepository.saveSleepRecord(record);
      return record;
    }
  }
}
