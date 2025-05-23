import 'package:flutter/material.dart';
import '../../models/food_model.dart';
import '../../models/food_type_model.dart';
import '../../services/food_service.dart';
import '../../services/food_type_service.dart';
import '../../generated/l10n.dart';
import '../../common/common_styles.dart';
import 'food_type_setting_dialog.dart';

void showFoodInputDialog(
    BuildContext context,
    List<FoodModel> foodData,
    Function(List<FoodModel>) onSave,
    ) async {
  final FoodTypeService foodTypeService = FoodTypeService();
  final FoodService foodService = FoodService();
  final locale = Localizations.localeOf(context).languageCode;
  final List<FoodTypeModel> foodTypes = await foodTypeService.getFoodTypes(locale);

  const List<String> mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Dessert'];

  // 음식 종류 토글 상태 설정
  final Map<String, bool> toggledFoods = {
    for (var type in foodTypes) type.name: foodData.any((food) => food.foodType == type.name),
  };

  final List<FoodModel> tempFoodData = List.from(foodData);

  void _toggleMealType(int index, String mealType, bool isSelected) {
    final mealTypesSet = tempFoodData[index].mealType.split(', ').toSet();
    if (isSelected) {
      mealTypesSet.add(mealType);
    } else {
      mealTypesSet.remove(mealType);
    }
    tempFoodData[index] = tempFoodData[index].copyWith(
      mealType: mealTypesSet.join(', ') ?? '',
    );
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
                Icon(Icons.fastfood, color: Color(0xFFAEDFF7)),
                SizedBox(width: 8),
                Text(
                  S.of(context).editFoodRecord,
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
                    Text(S.of(context).foodTypeSelect, style: CommonStyles.smallTextStyle),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...toggledFoods.keys.map((foodType) {
                          return FilterChip(
                            label: Text(foodType),
                            selected: toggledFoods[foodType] ?? false,
                            onSelected: (isSelected) {
                              setState(() {
                                toggledFoods[foodType] = isSelected;
                                if (isSelected) {
                                  tempFoodData.add(FoodModel(
                                    id: null,
                                    foodName: foodType,
                                    mealType: '',
                                    date: DateTime.now().toString(),
                                    foodType: foodType,
                                  ));
                                } else {
                                  final index = tempFoodData.indexWhere((food) => food.foodType == foodType);
                                  if (index != -1) {
                                    tempFoodData.removeAt(index);
                                  }
                                }
                              });
                            },
                            selectedColor: Colors.blueAccent.withOpacity(0.3),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                          );
                        }).toList(),
                        FilterChip(
                          label: Text(S.of(context).manageFoodTypes),
                          backgroundColor: Colors.grey[300],
                          onSelected: (isSelected) {
                            Navigator.pop(context);
                            showFoodTypeSettingsDialog(
                              context,
                              foodData: foodData,
                              onSave: onSave,
                            );
                          },
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(S.of(context).foodRecordInput, style: CommonStyles.smallTextStyle),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tempFoodData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 음식 이름
                              Text(
                                tempFoodData[index].foodName,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              // 초이스칩과 삭제 버튼을 한 줄로 배치
                              Row(
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      spacing: 8,
                                      children: mealTypes.map((mealType) {
                                        final isSelected = tempFoodData[index]
                                            .mealType
                                            .split(', ')
                                            .contains(mealType);
                                        return ChoiceChip(
                                          label: Text(mealType, style: TextStyle(fontSize: 12),),
                                          selected: isSelected,
                                          onSelected: (selected) {
                                            setState(() {
                                              _toggleMealType(index, mealType, selected);
                                            });
                                          },
                                          selectedColor: Colors.blueAccent.withOpacity(0.3),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  // 삭제 버튼
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      final foodType = tempFoodData[index].foodType;
                                      if (tempFoodData[index].id != null) {
                                        await foodService.deleteFood(tempFoodData[index].id!);
                                      }
                                      setState(() {
                                        toggledFoods[foodType] = false;
                                        tempFoodData.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey.shade300),
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
                onPressed: () {
                  onSave(tempFoodData);
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
