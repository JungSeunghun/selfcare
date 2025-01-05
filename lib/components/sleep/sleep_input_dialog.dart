import 'package:flutter/material.dart';
import '../../common/common_styles.dart';
import '../../models/sleep_record_model.dart';
import '../../generated/l10n.dart'; // S 클래스 사용

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
                  sleepData.id == null
                      ? S.of(context).addSleepRecord // "새로운 수면 기록 추가"
                      : S.of(context).editSleepRecord, // "수면 기록 수정"
                  style: CommonStyles.titleStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTimePickerRow(context, S.of(context).sleepTimeLabel, newSleepTime, (picked) => setState(() => newSleepTime = picked)),
                SizedBox(height: 16),
                _buildTimePickerRow(context, S.of(context).wakeTimeLabel, newWakeTime, (picked) => setState(() => newWakeTime = picked)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.of(context).cancel, style: TextStyle(color: Colors.grey)), // "취소"
              ),
              ElevatedButton(
                onPressed: () {
                  final updatedRecord = SleepRecord(
                    id: sleepData.id,
                    date: sleepData.date,
                    sleepTime: newSleepTime,
                    wakeTime: newWakeTime,
                    totalSleepDuration: calculateSleepDuration(context, newSleepTime, newWakeTime),
                  );
                  onSave(updatedRecord);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFAEDFF7),
                  shape: CommonStyles.dialogShape,
                ),
                child: Text(sleepData.id == null ? S.of(context).save : S.of(context).save), // "추가" 또는 "저장"
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

String calculateSleepDuration(BuildContext context, String sleepTime, String wakeTime) {
  try {
    final sleepParts = sleepTime.split(":").map(int.parse).toList();
    final wakeParts = wakeTime.split(":").map(int.parse).toList();
    final sleepMinutes = sleepParts[0] * 60 + sleepParts[1];
    final wakeMinutes = wakeParts[0] * 60 + wakeParts[1];
    final durationMinutes = (wakeMinutes - sleepMinutes + 24 * 60) % (24 * 60);
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;
    return "${hours}${S.of(context).hours} ${minutes}${S.of(context).minutes}"; // "시간" 및 "분" 추가
  } catch (e) {
    return "0${S.of(context).hours} 0${S.of(context).minutes}";
  }
}
