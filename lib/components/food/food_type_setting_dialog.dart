import 'package:flutter/material.dart';
import '../../models/food_model.dart';
import '../../models/food_type_model.dart';
import '../../services/food_type_service.dart';
import '../../common/common_styles.dart';
import '../../generated/l10n.dart'; // 다국어 S 클래스 사용
import 'food_input_dialog.dart'; // 🍽️ Food Input Dialog 추가

void showFoodTypeSettingsDialog(
    BuildContext context, {
      required List<FoodModel> foodData,
      required Function(List<FoodModel>) onSave,
    }) {
  final FoodTypeService foodTypeService = FoodTypeService();
  TextEditingController foodTypeController = TextEditingController();
  final locale = Localizations.localeOf(context).languageCode;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<FoodTypeModel>>(
        future: foodTypeService.getFoodTypes(locale),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return AlertDialog(
              shape: CommonStyles.dialogShape,
              title: Row(
                children: [
                  Icon(Icons.fastfood, color: Color(0xFFAEDFF7)),
                  SizedBox(width: 8),
                  Text(
                    S.of(context).foodTypeManagement,
                    style: CommonStyles.titleStyle.copyWith(fontSize: 18),
                  ),
                ],
              ),
              content: Text(S.of(context).noFoodTypes),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showFoodInputDialog(context, foodData, onSave);
                  },
                  child: Text(S.of(context).close, style: TextStyle(color: Colors.grey)),
                ),
              ],
            );
          }

          List<FoodTypeModel> foodTypes = snapshot.data!;

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: CommonStyles.dialogShape,
                title: Row(
                  children: [
                    Icon(Icons.fastfood, color: Color(0xFFAEDFF7)),
                    SizedBox(width: 8),
                    Text(
                      S.of(context).foodTypeManagement,
                      style: CommonStyles.titleStyle.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: foodTypeController,
                              decoration: InputDecoration(
                                hintText: S.of(context).addFoodType,
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
                              final newType = foodTypeController.text.trim();
                              if (newType.isNotEmpty) {
                                await foodTypeService.addFoodType(newType, locale);
                                foodTypeController.clear();
                                foodTypes = await foodTypeService.getFoodTypes(locale);
                                setState(() {});
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
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: foodTypes.length,
                          itemBuilder: (context, index) {
                            final type = foodTypes[index];
                            TextEditingController editController = TextEditingController(text: type.name);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: editController,
                                      decoration: InputDecoration(
                                        hintText: S.of(context).editFoodTypeHint,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(color: Colors.grey.shade300),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      ),
                                      onSubmitted: (newValue) async {
                                        if (newValue.trim().isNotEmpty && newValue != type.name) {
                                          await foodTypeService.updateFoodType(
                                            FoodTypeModel(id: type.id, name: newValue.trim(), locale: locale),
                                          );
                                          foodTypes = await foodTypeService.getFoodTypes(locale);
                                          setState(() {});
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
                                          await foodTypeService.deleteFoodType(type.id!);
                                          foodTypes = await foodTypeService.getFoodTypes(locale);
                                          setState(() {});
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
                      showFoodInputDialog(context, foodData, onSave);
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

void _showDeleteConfirmationDialog(
    BuildContext context,
    FoodTypeModel type,
    VoidCallback onDelete,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: CommonStyles.dialogShape,
        title: Text(S.of(context).deleteConfirmation),
        content: Text("${type.name} ${S.of(context).deleteFoodTypeConfirmation}"),
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
