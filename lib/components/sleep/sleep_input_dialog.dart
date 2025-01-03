import 'package:flutter/material.dart';
import '../../common/common_styles.dart';
import '../../models/sleep_record_model.dart';

void showSleepInputDialog(BuildContext context, SleepRecord sleepData, Function(SleepRecord) onSave) {
  String newSleepTime = sleepData.sleepTime;
  String newWakeTime = sleepData.wakeTime;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: CommonStyles.dialogShape,
            title: Row(
              children: [
                Icon(Icons.bedtime, color: Color(0xFFAEDFF7)),
                SizedBox(width: 8),
                Text(
                  sleepData.id == null ? "새로운 수면 기록 추가" : "수면 기록 수정",
                  style: CommonStyles.titleStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTimePickerRow(context, "잤는 시간", newSleepTime, (picked) => setState(() => newSleepTime = picked)),
                SizedBox(height: 16),
                _buildTimePickerRow(context, "일어난 시간", newWakeTime, (picked) => setState(() => newWakeTime = picked)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("취소", style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: () {
                  final updatedRecord = SleepRecord(
                    id: sleepData.id,
                    date: sleepData.date,
                    sleepTime: newSleepTime,
                    wakeTime: newWakeTime,
                    totalSleepDuration: calculateSleepDuration(newSleepTime, newWakeTime),
                  );
                  onSave(updatedRecord);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFAEDFF7),
                  shape: CommonStyles.dialogShape,
                ),
                child: Text(sleepData.id == null ? "추가" : "저장"),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget _buildTimePickerRow(BuildContext context, String label, String initialTime, ValueChanged<String> onTimePicked) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: CommonStyles.smallTextStyle),
      TextButton(
        onPressed: () async {
          final timeParts = initialTime.split(":").map(int.parse).toList();
          final picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: timeParts[0], minute: timeParts[1]),
          );
          if (picked != null) {
            onTimePicked("${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}");
          }
        },
        child: Text(initialTime, style: TextStyle(color: Colors.blue)),
      ),
    ],
  );
}

String calculateSleepDuration(String sleepTime, String wakeTime) {
  try {
    final sleepParts = sleepTime.split(":").map(int.parse).toList();
    final wakeParts = wakeTime.split(":").map(int.parse).toList();
    final sleepMinutes = sleepParts[0] * 60 + sleepParts[1];
    final wakeMinutes = wakeParts[0] * 60 + wakeParts[1];
    final durationMinutes = (wakeMinutes - sleepMinutes + 24 * 60) % (24 * 60);
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;
    return "${hours}시간 ${minutes}분";
  } catch (e) {
    return "0시간 0분";
  }
}
