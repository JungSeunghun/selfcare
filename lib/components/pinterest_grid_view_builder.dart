import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../services/sleep_service.dart';
import '../services/workout_service.dart';
import '../services/emotion_service.dart';
import '../services/income_expense_service.dart'; // 추가
import '../services/food_service.dart'; // 🍽️ 음식 서비스 추가
import '../services/log_service.dart'; // 📝 Log 서비스 추가
import '../models/sleep_record_model.dart';
import '../models/workout_record_model.dart';
import '../models/emotion_model.dart';
import '../models/income_expense_model.dart'; // 추가
import '../models/food_model.dart'; // 🍽️ 음식 모델 추가
import '../models/log_record_model.dart'; // 📝 오늘의 한줄 모델 추가
import 'sleep/sleep_card_widget.dart';
import 'workout/workout_card_widget.dart';
import 'emotion/emotion_card_widget.dart';
import 'income_expense/income_expense_card_widget.dart'; // 추가
import 'food/food_card_widget.dart'; // 🍽️ 음식 카드 위젯 추가

class PinterestGridViewBuilder extends StatelessWidget {
  final SleepRecord sleepData;
  final List<WorkoutRecord> workoutDataList;
  final List<Emotion> emotionDataList;
  final List<IncomeExpenseModel> incomeExpenseDataList; // 추가
  final List<FoodModel> foodDataList; // 🍽️ 음식 데이터 추가
  final LogRecord? logRecord; // 📝 오늘의 한줄 데이터 추가
  final Map<String, IconData> icons;
  final SleepService sleepService;
  final WorkoutService workoutService;
  final EmotionService emotionService;
  final IncomeExpenseService incomeExpenseService; // 추가
  final FoodService foodService; // 🍽️ 음식 서비스 추가
  final String selectedDate;
  final Function(SleepRecord) onUpdateSleep;
  final Function(List<WorkoutRecord>) onUpdateWorkout;
  final Function(List<Emotion>) onUpdateEmotion;
  final Function(List<IncomeExpenseModel>) onUpdateIncomeExpense; // 추가
  final Function(List<FoodModel>) onUpdateFood; // 🍽️ 음식 업데이트 추가
  final Function(String) onUpdateLog; // 📝 오늘의 한줄 업데이트 함수 추가

  const PinterestGridViewBuilder({
    required this.sleepData,
    required this.workoutDataList,
    required this.emotionDataList,
    required this.incomeExpenseDataList, // 추가
    required this.foodDataList, // 🍽️ 음식 데이터 추가
    required this.logRecord, // 📝 오늘의 한줄 데이터 추가
    required this.icons,
    required this.sleepService,
    required this.workoutService,
    required this.emotionService,
    required this.incomeExpenseService, // 추가
    required this.foodService, // 🍽️ 음식 서비스 추가
    required this.selectedDate,
    required this.onUpdateSleep,
    required this.onUpdateWorkout,
    required this.onUpdateEmotion,
    required this.onUpdateIncomeExpense, // 추가
    required this.onUpdateFood, // 🍽️ 음식 업데이트 추가
    required this.onUpdateLog, // 📝 오늘의 한줄 업데이트 함수 추가
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController logController = TextEditingController(text: logRecord?.note);

    return SingleChildScrollView(
      child: Column(
        children: [
          if (logRecord != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: logController,
                decoration: InputDecoration(
                  labelText: '오늘의 한 줄',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) => onUpdateLog(value),
              ),
            ),
          MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              final items = [
                sleepData,
                workoutDataList,
                emotionDataList,
                incomeExpenseDataList,
                foodDataList,
              ];
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

              if (item is List<IncomeExpenseModel>) {
                return IncomeExpenseCardWidget(
                  incomeExpenseData: item,
                  onSave: (List<IncomeExpenseModel> updatedExpenses) async {
                    final savedExpenses = await incomeExpenseService.saveIncomeExpenseList(
                      updatedExpenses.map((expense) => expense.copyWith(date: selectedDate)).toList(),
                    );
                    onUpdateIncomeExpense(savedExpenses);
                  },
                );
              }

              if (item is List<FoodModel>) {
                return FoodCardWidget(
                  foodData: item,
                  onSave: (List<FoodModel> updatedFoods) async {
                    final savedFoods = await foodService.saveFoodList(
                      updatedFoods.map((food) => food.copyWith(date: selectedDate)).toList(),
                    );
                    onUpdateFood(savedFoods);
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
