import 'package:flutter/material.dart';
import '../../models/emotion_model.dart';
import '../../models/emotion_type_model.dart';
import '../../services/emotion_type_service.dart';
import '../../common/common_styles.dart';
import '../../generated/l10n.dart'; // 다국어 S 클래스 사용

void showEmotionTypeSettingsDialog(
    BuildContext context, {
      required List<Emotion> emotionData,
      required Function(List<Emotion>) onSave,
    }) {
  final EmotionTypeService emotionTypeService = EmotionTypeService();
  TextEditingController emotionTypeController = TextEditingController();
  final locale = Localizations.localeOf(context).languageCode;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<EmotionType>>(
        future: emotionTypeService.getEmotionTypes(locale),
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
                    S.of(context).emotionTypeManagement,
                    style: CommonStyles.titleStyle.copyWith(fontSize: 18),
                  ),
                ],
              ),
              content: Text(S.of(context).noEmotionTypes),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).close, style: TextStyle(color: Colors.grey)),
                ),
              ],
            );
          }

          List<EmotionType> emotionTypes = snapshot.data!;

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: CommonStyles.dialogShape,
                title: Row(
                  children: [
                    Icon(Icons.category, color: Color(0xFFAEDFF7)),
                    SizedBox(width: 8),
                    Text(
                      S.of(context).emotionTypeManagement,
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
                              controller: emotionTypeController,
                              decoration: InputDecoration(
                                hintText: S.of(context).addEmotionType,
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
                              final newType = emotionTypeController.text.trim();
                              if (newType.isNotEmpty) {
                                await emotionTypeService.addEmotionType(newType, locale);
                                emotionTypeController.clear();
                                emotionTypes = await emotionTypeService.getEmotionTypes(locale);
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
                          itemCount: emotionTypes.length,
                          itemBuilder: (context, index) {
                            final type = emotionTypes[index];
                            TextEditingController editController = TextEditingController(text: type.name);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: editController,
                                      decoration: InputDecoration(
                                        hintText: S.of(context).editEmotionTypeHint,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(color: Colors.grey.shade300),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      ),
                                      onSubmitted: (newValue) async {
                                        if (newValue.trim().isNotEmpty && newValue != type.name) {
                                          await emotionTypeService.updateEmotionType(
                                            EmotionType(id: type.id, name: newValue.trim(), locale: locale),
                                          );
                                          emotionTypes = await emotionTypeService.getEmotionTypes(locale);
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
                                          await emotionTypeService.deleteEmotionType(type.id!);
                                          emotionTypes = await emotionTypeService.getEmotionTypes(locale);
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
    EmotionType type,
    VoidCallback onDelete,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: CommonStyles.dialogShape,
        title: Text(S.of(context).deleteConfirmation),
        content: Text("${type.name} ${S.of(context).deleteEmotionTypeConfirmation}"),
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
