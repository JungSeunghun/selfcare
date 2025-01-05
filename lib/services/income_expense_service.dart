import '../models/income_expense_model.dart';
import '../repositories/income_expense_repository.dart';

class IncomeExpenseService {
  final IncomeExpenseRepository _incomeExpenseRepository = IncomeExpenseRepository();

  /// 📋 모든 수입/지출 데이터 가져오기
  Future<List<IncomeExpenseModel>> getAllIncomeExpenses() async {
    return await _incomeExpenseRepository.getAllIncomeExpenses();
  }

  /// 🔍 날짜별 수입/지출 데이터 가져오기
  Future<List<IncomeExpenseModel>> getIncomeExpensesByDate(String date) async {
    try {
      return await _incomeExpenseRepository.getIncomeExpensesByDate(date);
    } catch (e) {
      print("Error fetching income/expenses by date: $e");
      return [];
    }
  }

  /// ➕ 수입/지출 데이터 저장 (리스트 형태로 한 번에 저장)
  Future<List<IncomeExpenseModel>> saveIncomeExpenseList(List<IncomeExpenseModel> incomeExpenses) async {
    List<IncomeExpenseModel> savedExpenses = [];

    for (var expense in incomeExpenses) {
      if (expense.id == null) {
        // 새 수입/지출 데이터 삽입
        final newExpense = await _incomeExpenseRepository.insertIncomeExpense(expense);
        savedExpenses.add(newExpense);
      } else {
        // 기존 수입/지출 데이터 업데이트
        await _incomeExpenseRepository.updateIncomeExpense(expense);
        savedExpenses.add(expense);
      }
    }

    return savedExpenses;
  }

  /// ✏️ 수입/지출 데이터 업데이트
  Future<void> updateIncomeExpense(IncomeExpenseModel incomeExpense) async {
    await _incomeExpenseRepository.updateIncomeExpense(incomeExpense);
  }

  /// ❌ 수입/지출 데이터 삭제
  Future<void> deleteIncomeExpense(int id) async {
    await _incomeExpenseRepository.deleteIncomeExpense(id);
  }
}
