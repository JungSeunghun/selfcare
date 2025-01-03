import 'package:flutter/material.dart';
import '../../models/workout_record_model.dart';
import '../../repositories/workout_type_repository.dart';
import '../../models/workout_type_model.dart';
import 'workout_input_dialog.dart';

void showWorkoutTypeSettingsDialog(
    BuildContext context, {
      required List<WorkoutRecord> workoutData,
      required Function(List<WorkoutRecord>) onSave,
    }) {
  final WorkoutTypeRepository _workoutTypeRepository = WorkoutTypeRepository();
  TextEditingController workoutTypeController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<WorkoutType>>(
        future: _workoutTypeRepository.getAllWorkoutTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return AlertDialog(
              title: Text("운동 타입 관리"),
              content: Text("운동 타입이 없습니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showWorkoutInputDialog(context, workoutData, onSave);
                  },
                  child: Text("닫기"),
                ),
              ],
            );
          }

          List<WorkoutType> workoutTypes = snapshot.data!;

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                title: Row(
                  children: [
                    Icon(Icons.category, color: Colors.blueAccent),
                    SizedBox(width: 8),
                    Text("운동 타입 관리", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 📝 입력 필드
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: workoutTypeController,
                              decoration: InputDecoration(
                                hintText: "새 운동 타입 입력",
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
                                await _workoutTypeRepository.addWorkoutType(newType);
                                workoutTypeController.clear();
                                workoutTypes = await _workoutTypeRepository.getAllWorkoutTypes();
                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("추가"),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // 📋 운동 타입 리스트
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
                                        hintText: "운동 타입 수정",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(color: Colors.grey.shade300),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      ),
                                      onSubmitted: (newValue) async {
                                        if (newValue.trim().isNotEmpty && newValue != type.name) {
                                          await _workoutTypeRepository.updateWorkoutType(
                                            WorkoutType(id: type.id, name: newValue.trim()),
                                          );
                                          workoutTypes = await _workoutTypeRepository.getAllWorkoutTypes();
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
                                          await _workoutTypeRepository.deleteWorkoutType(type.id!);
                                          workoutTypes = await _workoutTypeRepository.getAllWorkoutTypes();
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
                    child: Text("닫기"),
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
    BuildContext context, WorkoutType type, VoidCallback onDelete) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("삭제 확인"),
        content: Text("${type.name}을(를) 삭제하시겠습니까?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("취소"),
          ),
          ElevatedButton(
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("삭제"),
          ),
        ],
      );
    },
  );
}
