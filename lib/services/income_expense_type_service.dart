import '../models/income_expense_type_model.dart';
import '../repositories/income_expense_type_repository.dart';

class IncomeExpenseTypeService {
  final IncomeExpenseTypeRepository _incomeExpenseTypeRepository = IncomeExpenseTypeRepository();

  /// 특정 로케일에 따른 수입/지출 타입 가져오기
  Future<List<IncomeExpenseTypeModel>> getIncomeExpenseTypes(String locale) async {
    try {
      return await _incomeExpenseTypeRepository.getIncomeExpenseTypesByLocale(locale);
    } catch (e) {
      print("Error fetching income/expense types: $e");
      return [];
    }
  }

  /// ➕ 새로운 수입/지출 타입 추가
  Future<void> addIncomeExpenseType(String name, String locale, String category) async {
    try {
      final exists = await _incomeExpenseTypeRepository.incomeExpenseTypeExists(name);
      if (!exists) {
        await _incomeExpenseTypeRepository.addIncomeExpenseType(name, locale, category);
      } else {
        print("Income/expense type already exists.");
      }
    } catch (e) {
      print("Error adding income/expense type: $e");
    }
  }

  /// ✏️ 기존 수입/지출 타입 업데이트
  Future<void> updateIncomeExpenseType(IncomeExpenseTypeModel type) async {
    try {
      await _incomeExpenseTypeRepository.updateIncomeExpenseType(type);
    } catch (e) {
      print("Error updating income/expense type: $e");
    }
  }

  /// ❌ 수입/지출 타입 삭제
  Future<void> deleteIncomeExpenseType(int id) async {
    try {
      await _incomeExpenseTypeRepository.deleteIncomeExpenseType(id);
    } catch (e) {
      print("Error deleting income/expense type: $e");
    }
  }
}
