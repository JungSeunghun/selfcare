import 'package:flutter/material.dart';
import '../../common/common_styles.dart';
import '../../models/sleep_record_model.dart';
import 'sleep_input_dialog.dart';

class SleepCardWidget extends StatelessWidget {
  final SleepRecord sleepData;
  final Function(SleepRecord) onSave;

  const SleepCardWidget({
    required this.sleepData,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final isNewRecord = sleepData.id == null;
    final totalSleepDuration = calculateSleepDuration(sleepData.sleepTime, sleepData.wakeTime);

    return GestureDetector(
      onTap: () => showSleepInputDialog(context, sleepData, onSave),
      child: Container(
        decoration: CommonStyles.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.bedtime, size: 40, color: Colors.white),
                  SizedBox(width: 12),
                  Text("수면", style: CommonStyles.titleStyle),
                ],
              ),
              SizedBox(height: 24),
              if (isNewRecord)
                Center(
                  child: Text(
                    "오늘은 얼마나 푹 잤나요? 💤\n따뜻한 하루 되세요! 🌞",
                    textAlign: TextAlign.center,
                    style: CommonStyles.smallTextStyle.copyWith(
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else ...[
                Center(
                  child: Text(totalSleepDuration, style: CommonStyles.largeTextStyle),
                ),
                SizedBox(height: 12),
                Center(
                  child: Text(
                    "🛌 ${sleepData.sleepTime} ~ ⏰ ${sleepData.wakeTime}",
                    style: CommonStyles.smallTextStyle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 수면 시간 계산 메서드
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
}
