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
    final totalAmount = widget.incomeExpenseData.fold<double>(
      0.0,
          (sum, item) => sum + item.amount,
    );

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
                  Text(S.of(context).income_expense, style: CommonStyles.titleStyle),
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
                // 💰 각 수입/지출 기록 출력
                ...widget.incomeExpenseData.map((record) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Text(
                            record.type,
                            style: CommonStyles.smallTextStyle.copyWith(
                              color: record.type == 'income' ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${record.amount.toStringAsFixed(2)} ${S.of(context).currency}",
                            style: CommonStyles.smallTextStyle.copyWith(color: Colors.black54),
                          ),
                          if (record.description != null)
                            Text(
                              record.description!,
                              style: CommonStyles.smallTextStyle.copyWith(color: Colors.black45),
                            ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade300),
                    ],
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
