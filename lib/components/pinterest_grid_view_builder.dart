import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../services/sleep_service.dart';
import '../services/workout_service.dart';
import '../services/emotion_service.dart';
import '../models/sleep_record_model.dart';
import '../models/workout_record_model.dart';
import '../models/emotion_model.dart';
import 'sleep/sleep_card_widget.dart';
import 'workout/workout_card_widget.dart';
import 'emotion/emotion_card_widget.dart';

class PinterestGridViewBuilder extends StatelessWidget {
  final SleepRecord sleepData;
  final List<WorkoutRecord> workoutDataList;
  final List<Emotion> emotionDataList;
  final Map<String, IconData> icons;
  final SleepService sleepService;
  final WorkoutService workoutService;
  final EmotionService emotionService;
  final String selectedDate;
  final Function(SleepRecord) onUpdateSleep;
  final Function(List<WorkoutRecord>) onUpdateWorkout;
  final Function(List<Emotion>) onUpdateEmotion;

  const PinterestGridViewBuilder({
    required this.sleepData,
    required this.workoutDataList,
    required this.emotionDataList,
    required this.icons,
    required this.sleepService,
    required this.workoutService,
    required this.emotionService,
    required this.selectedDate,
    required this.onUpdateSleep,
    required this.onUpdateWorkout,
    required this.onUpdateEmotion,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      sleepData,
      workoutDataList,
      emotionDataList,
    ];

    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is SleepRecord) {
          return SleepCardWidget(
            sleepData: item,
            onSave: (SleepRecord updatedRecord) async {
              final newRecord = await sleepService.saveSleepRecord(
                updatedRecord.copyWith(date: selectedDate),
              );
              onUpdateSleep(newRecord);
            },
          );
        }

        if (item is List<WorkoutRecord>) {
          return WorkoutCardWidget(
            workoutData: item,
            onSave: (List<WorkoutRecord> updatedWorkouts) async {
              final savedWorkouts = await workoutService.saveWorkoutList(
                updatedWorkouts.map((workout) => workout.copyWith(date: selectedDate)).toList(),
              );
              onUpdateWorkout(savedWorkouts);
            },
          );
        }

        if (item is List<Emotion>) {
          return EmotionCardWidget(
            emotionData: item,
            onSave: (List<Emotion> updatedEmotions) async {
              final savedEmotions = await emotionService.saveEmotionList(
                updatedEmotions.map((emotion) => emotion.copyWith(date: selectedDate)).toList(),
              );
              onUpdateEmotion(savedEmotions);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
