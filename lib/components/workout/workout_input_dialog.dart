import 'package:flutter/material.dart';
import '../../models/workout_record_model.dart';
import '../../models/workout_type_model.dart';
import '../../services/workout_service.dart';
import '../../services/workout_type_service.dart';
import '../../generated/l10n.dart'; // 다국어 처리 S 클래스 사용
import '../../common/common_styles.dart'; // 공통 스타일 사용
import 'workout_type_settings_dialog.dart';

void showWorkoutInputDialog(
    BuildContext context,
    List<WorkoutRecord> workoutData,
    Function(List<WorkoutRecord>) onSave,
    ) async {
  final WorkoutTypeService workoutTypeService = WorkoutTypeService();
  final WorkoutService workoutService = WorkoutService();
  final List<WorkoutType> workoutTypes = await workoutTypeService.getAllWorkoutTypes();

  final Map<String, bool> toggledWorkouts = {
    for (var type in workoutTypes) type.name: workoutData.any((workout) => workout.workoutType == type.name),
  };

  final List<WorkoutRecord> tempWorkoutData = List.from(workoutData);
  final List<TextEditingController> durationControllers = List.generate(
    tempWorkoutData.length,
        (index) => TextEditingController(text: tempWorkoutData[index].duration.toString()),
  );

  void _toggleWorkout(String workoutType, bool isActive) {
    if (isActive) {
      tempWorkoutData.add(WorkoutRecord(id: null, date: DateTime.now().toString(), workoutType: workoutType, duration: 0));
      durationControllers.add(TextEditingController());
    } else {
      final index = tempWorkoutData.indexWhere((workout) => workout.workoutType == workoutType);
      if (index != -1) {
        tempWorkoutData.removeAt(index);
        durationControllers.removeAt(index);
      }
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
                Icon(Icons.fitness_center, color: Color(0xFFAEDFF7)),
                SizedBox(width: 8),
                Text(
                  S.of(context).editWorkoutRecord,
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
                    Text(S.of(context).workoutTypeSelect, style: CommonStyles.smallTextStyle),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...toggledWorkouts.keys.map((workout) {
                          return FilterChip(
                            label: Text(workout),
                            selected: toggledWorkouts[workout] ?? false,
                            onSelected: (isSelected) {
                              setState(() {
                                toggledWorkouts[workout] = isSelected;
                                _toggleWorkout(workout, isSelected);
                              });
                            },
                            selectedColor: Colors.blueAccent.withOpacity(0.3),
                          );
                        }).toList(),
                        FilterChip(
                          label: Text(S.of(context).addWorkoutType),
                          backgroundColor: Colors.grey[300],
                          onSelected: (isSelected) {
                            Navigator.pop(context);
                            showWorkoutTypeSettingsDialog(
                              context,
                              workoutData: workoutData,
                              onSave: onSave,
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(S.of(context).workoutRecordInput, style: CommonStyles.smallTextStyle),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tempWorkoutData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  tempWorkoutData[index].workoutType,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: durationControllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).durationInMinutes,
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  ),
                                  onChanged: (value) {
                                    final int duration = int.tryParse(value) ?? 0;
                                    tempWorkoutData[index] = tempWorkoutData[index].copyWith(duration: duration);
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  if (tempWorkoutData[index].id != null) {
                                    workoutService.deleteWorkoutRecord(tempWorkoutData[index].id!);
                                  }
                                  setState(() {
                                    toggledWorkouts[tempWorkoutData[index].workoutType] = false;
                                    tempWorkoutData.removeAt(index);
                                    durationControllers.removeAt(index);
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
                  for (int i = 0; i < tempWorkoutData.length; i++) {
                    tempWorkoutData[i] = tempWorkoutData[i].copyWith(
                      duration: int.tryParse(durationControllers[i].text) ?? 0,
                    );
                  }

                  List<WorkoutRecord> savedWorkouts = [];
                  for (var workout in tempWorkoutData) {
                    final savedRecord = await workoutService.saveWorkoutRecord(workout);
                    savedWorkouts.add(savedRecord);
                  }

                  onSave(savedWorkouts);
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
