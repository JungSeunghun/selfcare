import 'package:flutter/material.dart';
import '../../common/common_styles.dart';
import '../../generated/l10n.dart';
import '../../models/income_expense_model.dart';
import 'income_expense_input_dialog.dart';

class IncomeExpenseCardWidget extends StatefulWidget {
  final List<IncomeExpenseModel> incomeExpenseData;
  final Function(List<IncomeExpenseModel>) onSave;

  const IncomeExpenseCardWidget({
    required this.incomeExpenseData,
    required this.onSave,
  });

  @override
  _IncomeExpenseCardWidgetState createState() => _IncomeExpenseCardWidgetState();
}

class _IncomeExpenseCardWidgetState extends State<IncomeExpenseCardWidget> {
  @override
  Widget build(BuildContext context) {
    final totalIncome = widget.incomeExpenseData
        .where((item) => item.type == 'income')
        .fold<double>(0.0, (sum, item) => sum + item.amount);

    final totalExpense = widget.incomeExpenseData
        .where((item) => item.type == 'expense')
        .fold<double>(0.0, (sum, item) => sum + item.amount);

    final totalAmount = totalIncome - totalExpense;

    final isNewRecord = widget.incomeExpenseData.isEmpty;

    return GestureDetector(
      onTap: () => showIncomeExpenseInputDialog(
        context,
        widget.incomeExpenseData,
        widget.onSave,
      ),
      child: Container(
        decoration: CommonStyles.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 💰 아이콘과 제목
              Row(
                children: [
                  Icon(Icons.account_balance_wallet, size: 40, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      S.of(context).income_expense,
                      style: CommonStyles.titleStyle,
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // 🆕 새로운 기록일 때 메시지
              if (isNewRecord)
                Center(
                  child: Text(
                    S.of(context).noIncomeExpenseMessage,
                    textAlign: TextAlign.center,
                    style: CommonStyles.smallTextStyle.copyWith(
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                    softWrap: true,
                  ),
                )
              else ...[
                // 💰 수입 기록 출력
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    S.of(context).totalIncome,
                    style: CommonStyles.smallTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                ...widget.incomeExpenseData
                    .where((record) => record.type == 'income')
                    .map((record) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.description ?? S.of(context).unknown,
                          style: CommonStyles.smallTextStyle.copyWith(color: Colors.black87),
                        ),
                        Text(
                          "${record.amount.toStringAsFixed(2)} ${S.of(context).currency}",
                          style: CommonStyles.smallTextStyle.copyWith(color: Colors.green),
                        ),
                        Divider(color: Colors.grey.shade300),
                      ],
                    ),
                  );
                }).toList(),

                // 💸 지출 기록 출력
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    S.of(context).totalExpense,
                    style: CommonStyles.smallTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                ...widget.incomeExpenseData
                    .where((record) => record.type == 'expense')
                    .map((record) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.description ?? S.of(context).unknown,
                          style: CommonStyles.smallTextStyle.copyWith(color: Colors.black87),
                        ),
                        Text(
                          "${record.amount.toStringAsFixed(2)} ${S.of(context).currency}",
                          style: CommonStyles.smallTextStyle.copyWith(color: Colors.red),
                        ),
                        Divider(color: Colors.grey.shade300),
                      ],
                    ),
                  );
                }).toList(),

                // 💵 총 수입/지출 금액 출력
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "${S.of(context).totalIncomeExpense}: ${totalAmount.toStringAsFixed(2)} ${S.of(context).currency}",
                      style: CommonStyles.smallTextStyle.copyWith(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
