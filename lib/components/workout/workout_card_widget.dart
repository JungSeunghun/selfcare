import 'package:flutter/material.dart';
import '../../common/common_styles.dart';
import '../../models/workout_record_model.dart';
import 'workout_input_dialog.dart';

class WorkoutCardWidget extends StatefulWidget {
  final List<WorkoutRecord> workoutData;
  final Function(List<WorkoutRecord>) onSave;

  const WorkoutCardWidget({
    required this.workoutData,
    required this.onSave,
  });

  @override
  _WorkoutCardWidgetState createState() => _WorkoutCardWidgetState();
}

class _WorkoutCardWidgetState extends State<WorkoutCardWidget> {
  @override
  Widget build(BuildContext context) {
    final totalDuration = widget.workoutData.fold<int>(
      0,
          (sum, item) => sum + item.duration,
    );

    final isNewRecord = widget.workoutData.isEmpty;

    return GestureDetector(
      onTap: () => showWorkoutInputDialog(context, widget.workoutData, widget.onSave),
      child: Container(
        decoration: CommonStyles.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🏋️ 아이콘과 제목
              Row(
                children: [
                  Icon(Icons.fitness_center, size: 40, color: Colors.white),
                  SizedBox(width: 12),
                  Text("운동", style: CommonStyles.titleStyle),
                ],
              ),
              SizedBox(height: 24),

              // 🆕 새로운 기록일 때 메시지
              if (isNewRecord)
                Center(
                  child: Text(
                    "오늘은 어떤 운동을 했나요? 🏋️\n작은 움직임이 큰 변화를 만듭니다! 💪",
                    textAlign: TextAlign.center,
                    style: CommonStyles.smallTextStyle.copyWith(
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else ...[
                // 🏋️ 각 운동 기록 출력
                ...widget.workoutData.map((workout) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            workout.workoutType,
                            style: CommonStyles.smallTextStyle.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${workout.duration}분",
                            style: CommonStyles.smallTextStyle.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade300),
                    ],
                  );
                }).toList(),

                // 🧮 총 운동 시간 출력
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "총 운동 시간: ${totalDuration}분",
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
