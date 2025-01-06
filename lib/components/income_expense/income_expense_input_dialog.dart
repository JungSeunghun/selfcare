import 'package:flutter/material.dart';
import '../../models/income_expense_model.dart';
import '../../models/income_expense_type_model.dart';
import '../../services/income_expense_service.dart';
import '../../services/income_expense_type_service.dart';
import '../../generated/l10n.dart'; // 다국어 처리 S 클래스 사용
import '../../common/common_styles.dart'; // 공통 스타일 사용

void showIncomeExpenseInputDialog(
    BuildContext context,
    List<IncomeExpenseModel> incomeExpenseData,
    Function(List<IncomeExpenseModel>) onSave,
    ) async {
  final IncomeExpenseService incomeExpenseService = IncomeExpenseService();
  final IncomeExpenseTypeService incomeExpenseTypeService = IncomeExpenseTypeService();

  // 수입/지출 타입 불러오기
  final locale = Localizations.localeOf(context).languageCode;
  final List<IncomeExpenseTypeModel> incomeExpenseTypes =
  await incomeExpenseTypeService.getIncomeExpenseTypes(locale);

  // 수입과 지출 타입을 분리
  final List<IncomeExpenseTypeModel> incomeTypes =
  incomeExpenseTypes.where((type) => type.category == 'income').toList();
  final List<IncomeExpenseTypeModel> expenseTypes =
  incomeExpenseTypes.where((type) => type.category == 'expense').toList();

  final List<IncomeExpenseModel> tempIncomeExpenseData = List.from(incomeExpenseData);
  final List<TextEditingController> amountControllers = List.generate(
    tempIncomeExpenseData.length,
        (index) => TextEditingController(text: tempIncomeExpenseData[index].amount.toStringAsFixed(2)),
  );

  void _addIncomeExpenseRecord(String type, String description) {
    tempIncomeExpenseData.add(IncomeExpenseModel(
      id: null,
      type: type,
      amount: 0.0,
      description: description,
      date: DateTime.now().toString(),
    ));
    amountControllers.add(TextEditingController());
  }

  void _removeIncomeExpenseRecord(String description) {
    final index = tempIncomeExpenseData.indexWhere((record) => record.description == description);
    if (index != -1) {
      tempIncomeExpenseData.removeAt(index);
      amountControllers.removeAt(index);
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: CommonStyles.dialogShape,
            title: Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Color(0xFFAEDFF7)),
                SizedBox(width: 8),
                Text(
                  S.of(context).editIncomeExpenseRecord,
                  style: CommonStyles.titleStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 수입 섹션
                    Text(S.of(context).addIncome, style: CommonStyles.smallTextStyle.copyWith(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: incomeTypes.map((type) {
                        final isSelected = tempIncomeExpenseData.any((record) => record.description == type.name);
                        return FilterChip(
                          label: Text(type.name),
                          selected: isSelected,
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                _addIncomeExpenseRecord('income', type.name);
                              } else {
                                _removeIncomeExpenseRecord(type.name);
                              }
                            });
                          },
                          selectedColor: Colors.green.withOpacity(0.3),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: Colors.green.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),

                    // 지출 섹션
                    Text(S.of(context).addExpense, style: CommonStyles.smallTextStyle.copyWith(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: expenseTypes.map((type) {
                        final isSelected = tempIncomeExpenseData.any((record) => record.description == type.name);
                        return FilterChip(
                          label: Text(type.name),
                          selected: isSelected,
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                _addIncomeExpenseRecord('expense', type.name);
                              } else {
                                _removeIncomeExpenseRecord(type.name);
                              }
                            });
                          },
                          selectedColor: Colors.red.withOpacity(0.3),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: Colors.red.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),

                    // 수입/지출 데이터 입력 필드
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tempIncomeExpenseData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              // 타입 표시 (income/expense)
                              Expanded(
                                flex: 2,
                                child: Text(
                                  tempIncomeExpenseData[index].description ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: tempIncomeExpenseData[index].type == 'income'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),

                              // 금액 입력 필드
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: amountControllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).enterAmount,
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  ),
                                  onChanged: (value) {
                                    final double amount = double.tryParse(value) ?? 0.0;
                                    tempIncomeExpenseData[index] =
                                        tempIncomeExpenseData[index].copyWith(amount: amount);
                                  },
                                ),
                              ),

                              // 삭제 버튼
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  if (tempIncomeExpenseData[index].id != null) {
                                    incomeExpenseService.deleteIncomeExpense(tempIncomeExpenseData[index].id!);
                                  }
                                  setState(() {
                                    tempIncomeExpenseData.removeAt(index);
                                    amountControllers.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(S.of(context).cancel, style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: () async {
                  for (int i = 0; i < tempIncomeExpenseData.length; i++) {
                    tempIncomeExpenseData[i] = tempIncomeExpenseData[i].copyWith(
                      amount: double.tryParse(amountControllers[i].text) ?? 0.0,
                    );
                  }

                  onSave(tempIncomeExpenseData);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFAEDFF7),
                  shape: CommonStyles.dialogShape,
                ),
                child: Text(S.of(context).save),
              ),
            ],
          );
        },
      );
    },
  );
}
