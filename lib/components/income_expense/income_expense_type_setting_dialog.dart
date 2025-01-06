import 'package:flutter/material.dart';
import '../../models/income_expense_model.dart';
import '../../models/income_expense_type_model.dart';
import '../../services/income_expense_type_service.dart';
import '../../common/common_styles.dart';
import '../../generated/l10n.dart'; // 다국어 S 클래스 사용
import 'income_expense_input_dialog.dart'; // 추가된 파일 임포트

void showIncomeExpenseTypeSettingsDialog(
    BuildContext context, {
      required Function() onUpdate,
      required String category, // 'income' 또는 'expense'
      required List<IncomeExpenseModel> incomeExpenseData,
      required Function(List<IncomeExpenseModel>) onSave,
    }) {
  final IncomeExpenseTypeService incomeExpenseTypeService = IncomeExpenseTypeService();
  TextEditingController typeController = TextEditingController();
  final locale = Localizations.localeOf(context).languageCode;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<IncomeExpenseTypeModel>>(
        future: incomeExpenseTypeService.getIncomeExpenseTypes(locale),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return AlertDialog(
              shape: CommonStyles.dialogShape,
              title: _buildDialogTitle(context, category),
              content: Text(category == 'income'
                  ? S.of(context).noIncomeTypes
                  : S.of(context).noExpenseTypes),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // 다이얼로그 닫힌 후 입력 다이얼로그 다시 열기
                    showIncomeExpenseInputDialog(
                      context,
                      incomeExpenseData,
                      onSave,
                    );
                  },
                  child: Text(S.of(context).close, style: TextStyle(color: Colors.grey)),
                ),
              ],
            );
          }

          List<IncomeExpenseTypeModel> incomeExpenseTypes = snapshot.data!
              .where((type) => type.category == category)
              .toList();

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: CommonStyles.dialogShape,
                title: _buildDialogTitle(context, category),
                content: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 입력 필드와 버튼
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: typeController,
                              decoration: InputDecoration(
                                hintText: category == 'income'
                                    ? S.of(context).addIncomeType
                                    : S.of(context).addExpenseType,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              final newType = typeController.text.trim();
                              if (newType.isNotEmpty) {
                                await incomeExpenseTypeService.addIncomeExpenseType(
                                    newType, locale, category);
                                typeController.clear();
                                incomeExpenseTypes = await incomeExpenseTypeService
                                    .getIncomeExpenseTypes(locale)
                                    .then((types) =>
                                    types.where((type) => type.category == category).toList());
                                setState(() {});
                                onUpdate();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFAEDFF7),
                              shape: CommonStyles.dialogShape,
                            ),
                            child: Text(S.of(context).add),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // 리스트뷰
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: incomeExpenseTypes.length,
                          itemBuilder: (context, index) {
                            final type = incomeExpenseTypes[index];
                            TextEditingController editController =
                            TextEditingController(text: type.name);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: editController,
                                      decoration: InputDecoration(
                                        hintText: category == 'income'
                                            ? S.of(context).editIncomeTypeHint
                                            : S.of(context).editExpenseTypeHint,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(color: Colors.grey.shade300),
                                        ),
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      ),
                                      onSubmitted: (newValue) async {
                                        if (newValue.trim().isNotEmpty &&
                                            newValue != type.name) {
                                          await incomeExpenseTypeService.updateIncomeExpenseType(
                                            IncomeExpenseTypeModel(
                                              id: type.id,
                                              name: newValue.trim(),
                                              category: type.category,
                                              locale: locale,
                                            ),
                                          );
                                          incomeExpenseTypes = await incomeExpenseTypeService
                                              .getIncomeExpenseTypes(locale)
                                              .then((types) => types
                                              .where((type) => type.category == category)
                                              .toList());
                                          setState(() {});
                                          onUpdate();
                                        }
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      _showDeleteConfirmationDialog(
                                        context,
                                        type,
                                            () async {
                                          await incomeExpenseTypeService
                                              .deleteIncomeExpenseType(type.id!);
                                          incomeExpenseTypes = await incomeExpenseTypeService
                                              .getIncomeExpenseTypes(locale)
                                              .then((types) => types
                                              .where((type) => type.category == category)
                                              .toList());
                                          setState(() {});
                                          onUpdate();
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // 다이얼로그 닫힌 후 입력 다이얼로그 다시 열기
                      showIncomeExpenseInputDialog(
                        context,
                        incomeExpenseData,
                        onSave,
                      );
                    },
                    child: Text(S.of(context).close, style: TextStyle(color: Colors.grey)),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

Widget _buildDialogTitle(BuildContext context, String category) {
  return Row(
    children: [
      Icon(Icons.category, color: Color(0xFFAEDFF7)),
      SizedBox(width: 8),
      Text(
        category == 'income'
            ? S.of(context).manageIncomeTypes
            : S.of(context).manageExpenseTypes,
        style: CommonStyles.titleStyle.copyWith(fontSize: 18),
      ),
    ],
  );
}

void _showDeleteConfirmationDialog(
    BuildContext context,
    IncomeExpenseTypeModel type,
    VoidCallback onDelete,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: CommonStyles.dialogShape,
        title: Text(S.of(context).deleteConfirmation),
        content: Text("${type.name} ${S.of(context).deleteIncomeExpenseTypeConfirmation}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(S.of(context).cancel, style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: CommonStyles.dialogShape,
            ),
            child: Text(S.of(context).delete),
          ),
        ],
      );
    },
  );
}