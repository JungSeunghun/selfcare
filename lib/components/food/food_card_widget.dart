import 'package:flutter/material.dart';
import '../../common/common_styles.dart';
import '../../generated/l10n.dart';
import '../../models/food_model.dart';
import 'food_input_dialog.dart';

class FoodCardWidget extends StatefulWidget {
  final List<FoodModel> foodData;
  final Function(List<FoodModel>) onSave;

  const FoodCardWidget({
    required this.foodData,
    required this.onSave,
  });

  @override
  _FoodCardWidgetState createState() => _FoodCardWidgetState();
}

class _FoodCardWidgetState extends State<FoodCardWidget> {
  @override
  Widget build(BuildContext context) {
    final isNewRecord = widget.foodData.isEmpty;

    return GestureDetector(
      onTap: () => showFoodInputDialog(context, widget.foodData, widget.onSave),
      child: Container(
        decoration: CommonStyles.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🍽️ 아이콘과 제목
              Row(
                children: [
                  Icon(Icons.fastfood, size: 40, color: Colors.white),
                  SizedBox(width: 12),
                  Text(S.of(context).food, style: CommonStyles.titleStyle),
                ],
              ),
              SizedBox(height: 24),

              // 🆕 새로운 기록일 때 메시지
              if (isNewRecord)
                Center(
                  child: Text(
                    S.of(context).noFoodMessage,
                    textAlign: TextAlign.center,
                    style: CommonStyles.smallTextStyle.copyWith(
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                    softWrap: true,
                  ),
                )
              else ...[
                // 🍽️ 각 음식 기록 출력
                ...widget.foodData.map((food) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Text(
                            food.foodName,
                            style: CommonStyles.smallTextStyle.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${food.mealType}",
                            style: CommonStyles.smallTextStyle.copyWith(color: Colors.black54),
                          ),
                          Text(
                            food.date,
                            style: CommonStyles.smallTextStyle.copyWith(color: Colors.black45),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade300),
                    ],
                  );
                }).toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
