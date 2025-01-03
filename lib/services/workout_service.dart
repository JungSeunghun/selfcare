import '../models/workout_record_model.dart';
import '../repositories/workout_repository.dart';

class WorkoutService {
  final WorkoutRepository _workoutRepository = WorkoutRepository();

  Future<List<WorkoutRecord>> getWorkoutsByDate(String date) async {
    return await _workoutRepository.getWorkoutsByDate(date);
  }

  Future<WorkoutRecord> saveWorkoutRecord(WorkoutRecord record) async {
    if (record.id == null) {
      final newId = await _workoutRepository.insertWorkout(record);
      return record.copyWith(id: newId);
    } else {
      await _workoutRepository.updateWorkout(record);
      return record;
    }
  }

  Future<List<WorkoutRecord>> saveWorkoutList(List<WorkoutRecord> records) async {
    List<WorkoutRecord> updatedRecords = [];
    for (WorkoutRecord record in records) {
      final updatedRecord = await saveWorkoutRecord(record);
      updatedRecords.add(updatedRecord);
    }
    return updatedRecords;
  }

  Future<void> deleteWorkoutRecord(int id) async {
    await _workoutRepository.deleteWorkout(id);
  }
}
