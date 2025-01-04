import 'package:flutter/material.dart';
import '../../models/workout_record_model.dart';
import '../../models/workout_type_model.dart';
import '../../services/workout_type_service.dart';
import '../../common/common_styles.dart';
import '../../generated/l10n.dart'; // 다국어 S 클래스 사용
import 'workout_input_dialog.dart';

void showWorkoutTypeSettingsDialog(
    BuildContext context, {
      required List<WorkoutRecord> workoutData,
      required Function(List<WorkoutRecord>) onSave,
    }) {
  final WorkoutTypeService workoutTypeService = WorkoutTypeService();
  TextEditingController workoutTypeController = TextEditingController();
  final locale = Localizations.localeOf(context).languageCode;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<WorkoutType>>(
        future: workoutTypeService.getWorkoutTypesByLocale(locale),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return AlertDialog(
              shape: CommonStyles.dialogShape,
              title: Row(
                children: [
                  Icon(Icons.category, color: Color(0xFFAEDFF7)),
                  SizedBox(width: 8),
                  Text(
                    S.of(context).workoutTypeManagement,
                    style: CommonStyles.titleStyle.copyWith(fontSize: 18),
                  ),
                ],
              ),
              content: Text(S.of(context).noWorkoutTypes),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showWorkoutInputDialog(context, workoutData, onSave);
                  },
                  child: Text(S.of(context).close, style: TextStyle(color: Colors.grey)),
                ),
              ],
            );
          }

          List<WorkoutType> workoutTypes = snapshot.data!;

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: CommonStyles.dialogShape,
                title: Row(
                  children: [
                    Icon(Icons.category, color: Color(0xFFAEDFF7)),
                    SizedBox(width: 8),
                    Text(
                      S.of(context).workoutTypeManagement,
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
                              controller: workoutTypeController,
                              decoration: InputDecoration(
                                hintText: S.of(context).addWorkoutType,
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
                              final newType = workoutTypeController.text.trim();
                              if (newType.isNotEmpty) {
                                await workoutTypeService.addWorkoutType(newType, locale);
                                workoutTypeController.clear();
                                workoutTypes = await workoutTypeService.getWorkoutTypesByLocale(locale);
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
                          itemCount: workoutTypes.length,
                          itemBuilder: (context, index) {
                            final type = workoutTypes[index];
                            TextEditingController editController = TextEditingController(text: type.name);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: editController,
                                      decoration: InputDecoration(
                                        hintText: S.of(context).addNewWorkoutTypeHint,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(color: Colors.grey.shade300),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      ),
                                      onSubmitted: (newValue) async {
                                        if (newValue.trim().isNotEmpty && newValue != type.name) {
                                          await workoutTypeService.updateWorkoutType(
                                            WorkoutType(id: type.id, name: newValue.trim(), locale: locale),
                                          );
                                          workoutTypes = await workoutTypeService.getWorkoutTypesByLocale(locale);
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
                                          await workoutTypeService.deleteWorkoutType(type.id!);
                                          workoutTypes = await workoutTypeService.getWorkoutTypesByLocale(locale);
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
                      showWorkoutInputDialog(context, workoutData, onSave);
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
    WorkoutType type,
    VoidCallback onDelete,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: CommonStyles.dialogShape,
        title: Text(S.of(context).deleteConfirmation),
        content: Text("${type.name} ${S.of(context).deleteWorkoutTypeConfirmation}"),
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
