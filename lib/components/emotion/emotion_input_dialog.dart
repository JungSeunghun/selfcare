import 'package:flutter/material.dart';
import '../../models/emotion_model.dart';
import '../../models/emotion_type_model.dart';
import '../../services/emotion_service.dart';
import '../../services/emotion_type_service.dart';
import '../../common/common_styles.dart';
import '../../generated/l10n.dart';
import 'emotion_type_settings_dialog.dart'; // S 클래스 사용

void showEmotionInputDialog(
    BuildContext context,
    List<Emotion> emotionData,
    Function(List<Emotion>) onSave,
    ) async {
  final EmotionTypeService emotionTypeService = EmotionTypeService();
  final EmotionService emotionService = EmotionService();
  final locale = Localizations.localeOf(context).languageCode;
  final List<EmotionType> emotionTypes = await emotionTypeService.getEmotionTypes(locale);

  final Map<String, bool> toggledEmotions = {
    for (var type in emotionTypes) type.name: emotionData.any((emotion) => emotion.emotionType == type.name),
  };

  final List<Emotion> tempEmotionData = List.from(emotionData);
  final List<TextEditingController> intensityControllers = List.generate(
    tempEmotionData.length,
        (index) => TextEditingController(text: tempEmotionData[index].intensity.toString()),
  );

  void _toggleEmotion(String emotionType, bool isActive) {
    if (isActive) {
      tempEmotionData.add(Emotion(id: null, date: DateTime.now().toString(), emotionType: emotionType, intensity: 0));
      intensityControllers.add(TextEditingController());
    } else {
      final index = tempEmotionData.indexWhere((emotion) => emotion.emotionType == emotionType);
      if (index != -1) {
        tempEmotionData.removeAt(index);
        intensityControllers.removeAt(index);
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
                Icon(Icons.sentiment_satisfied, color: Color(0xFFAEDFF7)),
                SizedBox(width: 8),
                Text(
                  S.of(context).editEmotionRecord,
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
                    Text(S.of(context).emotionTypeSelect, style: CommonStyles.smallTextStyle),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...toggledEmotions.keys.map((emotionType) {
                          return FilterChip(
                            label: Text(emotionType),
                            selected: toggledEmotions[emotionType] ?? false,
                            onSelected: (isSelected) {
                              setState(() {
                                toggledEmotions[emotionType] = isSelected;
                                _toggleEmotion(emotionType, isSelected);
                              });
                            },
                            selectedColor: Colors.blueAccent.withOpacity(0.3),
                          );
                        }).toList(),
                        FilterChip(
                          label: Text(S.of(context).addEmotionType),
                          backgroundColor: Colors.grey[300],
                          onSelected: (isSelected) {
                            Navigator.pop(context);
                            showEmotionTypeSettingsDialog(
                              context,
                              emotionData: emotionData,
                              onSave: onSave,
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(S.of(context).emotionRecordInput, style: CommonStyles.smallTextStyle),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tempEmotionData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  tempEmotionData[index].emotionType,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: intensityControllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).intensityLabel,
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  ),
                                  onChanged: (value) {
                                    final int intensity = int.tryParse(value) ?? 0;
                                    tempEmotionData[index] = tempEmotionData[index].copyWith(intensity: intensity);
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  if (tempEmotionData[index].id != null) {
                                    emotionService.deleteEmotion(tempEmotionData[index].id!);
                                  }
                                  setState(() {
                                    toggledEmotions[tempEmotionData[index].emotionType] = false;
                                    tempEmotionData.removeAt(index);
                                    intensityControllers.removeAt(index);
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
                  for (int i = 0; i < tempEmotionData.length; i++) {
                    tempEmotionData[i] = tempEmotionData[i].copyWith(
                      intensity: int.tryParse(intensityControllers[i].text) ?? 0,
                    );
                  }

                  List<Emotion> savedEmotions = [];
                  for (var emotion in tempEmotionData) {
                    savedEmotions.add(emotion);
                  }

                  onSave(savedEmotions);
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
