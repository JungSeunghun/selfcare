import '../models/workout_type_model.dart';
import '../repositories/workout_type_repository.dart';

class WorkoutTypeService {
  final WorkoutTypeRepository _workoutTypeRepository = WorkoutTypeRepository();

  /// 📋 모든 운동 타입 가져오기
  Future<List<WorkoutType>> getAllWorkoutTypes() async {
    try {
      return await _workoutTypeRepository.getAllWorkoutTypes();
    } catch (e) {
      print("Error fetching workout types: $e");
      return [];
    }
  }

  /// ➕ 새로운 운동 타입 추가
  Future<void> addWorkoutType(String name) async {
    try {
      final exists = await _workoutTypeRepository.workoutTypeExists(name);
      if (!exists) {
        await _workoutTypeRepository.addWorkoutType(name);
      } else {
        print("Workout type already exists.");
      }
    } catch (e) {
      print("Error adding workout type: $e");
    }
  }

  /// ✏️ 기존 운동 타입 업데이트
  Future<void> updateWorkoutType(WorkoutType workoutType) async {
    try {
      await _workoutTypeRepository.updateWorkoutType(workoutType);
    } catch (e) {
      print("Error updating workout type: $e");
    }
  }

  /// ❌ 운동 타입 삭제
  Future<void> deleteWorkoutType(int id) async {
    try {
      await _workoutTypeRepository.deleteWorkoutType(id);
    } catch (e) {
      print("Error deleting workout type: $e");
    }
  }

  /// 🔍 운동 타입 존재 여부 확인
  Future<bool> workoutTypeExists(String name) async {
    try {
      return await _workoutTypeRepository.workoutTypeExists(name);
    } catch (e) {
      print("Error checking workout type existence: $e");
      return false;
    }
  }
}
