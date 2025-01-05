import 'package:flutter/material.dart';
import '../../common/common_styles.dart';
import '../../models/emotion_model.dart';
import '../../generated/l10n.dart'; // 다국어 처리
import 'emotion_input_dialog.dart'; // 감정 입력 다이얼로그

class EmotionCardWidget extends StatelessWidget {
  final List<Emotion> emotionData;
  final Function(List<Emotion>) onSave;

  const EmotionCardWidget({
    required this.emotionData,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final isNewRecord = emotionData.isEmpty;

    return GestureDetector(
      onTap: () => showEmotionInputDialog(context, emotionData, onSave),
      child: Container(
        decoration: CommonStyles.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sentiment_satisfied, size: 40, color: Colors.white),
                  SizedBox(width: 12),
                  Text(S.of(context).emotion, style: CommonStyles.titleStyle),
                ],
              ),
              SizedBox(height: 24),
              if (isNewRecord)
                Center(
                  child: Text(
                    S.of(context).emotionMessage,
                    textAlign: TextAlign.center,
                    style: CommonStyles.smallTextStyle.copyWith(
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                    softWrap: true,
                  ),
                )
              else ...[
                // 감정 데이터 출력
                ...emotionData.map((emotion) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          emotion.emotionType,
                          style: CommonStyles.smallTextStyle.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${emotion.intensity} ${S.of(context).intensityLabel}",
                          style: CommonStyles.smallTextStyle.copyWith(color: Colors.black54),
                        ),
                      ],
                    ),
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
