import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'generated/l10n.dart';
import 'components/pinterest_grid_view_builder.dart';
import 'components/date_header.dart';
import 'services/sleep_service.dart';
import 'services/workout_service.dart';
import 'services/emotion_service.dart';
import 'services/income_expense_service.dart';
import 'services/food_service.dart'; // 🍽️ 음식 서비스 추가
import 'services/log_service.dart'; // 📝 Log 서비스 추가
import 'models/sleep_record_model.dart';
import 'models/workout_record_model.dart';
import 'models/emotion_model.dart';
import 'models/income_expense_model.dart';
import 'models/food_model.dart'; // 🍽️ 음식 모델 추가
import 'models/log_record_model.dart'; // 📝 Log 모델 추가
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, IconData> icons = {
    S.current.sleep: Ionicons.bed_outline,
    S.current.workout: Ionicons.fitness_outline,
    S.current.emotion: Ionicons.happy_outline,
    S.current.income_expense: Ionicons.cash_outline,
    S.current.food: Ionicons.fast_food_outline, // 🍽️ 음식 아이콘 추가
  };

  final SleepService _sleepService = SleepService();
  final WorkoutService _workoutService = WorkoutService();
  final EmotionService _emotionService = EmotionService();
  final IncomeExpenseService _incomeExpenseService = IncomeExpenseService();
  final FoodService _foodService = FoodService(); // 🍽️ 음식 서비스 추가
  final LogService _logService = LogService(); // 📝 Log 서비스 추가

  String selectedDate = DateFormat('yMd').format(DateTime.now());
  late SleepRecord sleepData;
  List<WorkoutRecord> workoutData = [];
  List<Emotion> emotionData = [];
  List<IncomeExpenseModel> incomeExpenses = [];
  List<FoodModel> foodData = []; // 🍽️ 음식 데이터 추가
  LogRecord? logRecord; // 📝 오늘의 한줄 데이터 추가
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDataForDate(selectedDate);
  }

  Future<void> _loadDataForDate(String date) async {
    setState(() {
      isLoading = true;
    });

    final sleepRecord = await _sleepService.getSleepRecordByDate(date);
    final workouts = await _workoutService.getWorkoutsByDate(date);
    final emotions = await _emotionService.getEmotionsByDate(date);
    final expenses = await _incomeExpenseService.getIncomeExpensesByDate(date);
    final foods = await _foodService.getFoodsByDate(date); // 🍽️ 음식 데이터 로드
    final log = await _logService.getLogRecordByDate(date); // 📝 오늘의 한줄 로드

    setState(() {
      sleepData = sleepRecord;
      workoutData = workouts;
      emotionData = emotions;
      incomeExpenses = expenses;
      foodData = foods; // 🍽️ 음식 데이터 업데이트
      logRecord = log; // 📝 오늘의 한줄 업데이트
      isLoading = false;
    });
  }

  // 📝 오늘의 한줄 입력 함수
  Future<void> _saveLog(String note) async {
    final newLog = LogRecord(
      id: logRecord?.id,
      note: note,
      date: selectedDate,
    );
    await _logService.saveLogRecord(newLog);
    setState(() {
      logRecord = newLog;
    });
  }

  // 💤 수면 데이터 업데이트 함수
  void _updateSleepData(SleepRecord updatedRecord) {
    setState(() {
      sleepData = updatedRecord;
    });
  }

  // 🏋️ 운동 데이터 업데이트 함수
  void _updateWorkoutData(List<WorkoutRecord> updatedRecords) {
    setState(() {
      workoutData = updatedRecords;
    });
  }

  // 😊 감정 데이터 업데이트 함수
  void _updateEmotionData(List<Emotion> updatedRecords) {
    setState(() {
      emotionData = updatedRecords;
    });
  }

  // 💵 수입/지출 데이터 업데이트 함수
  void _updateIncomeExpenseData(List<IncomeExpenseModel> updatedRecords) {
    setState(() {
      incomeExpenses = updatedRecords;
    });
  }

  // 🍽️ 음식 데이터 업데이트 함수
  void _updateFoodData(List<FoodModel> updatedRecords) {
    setState(() {
      foodData = updatedRecords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                DateHeader(
                  selectedDate: selectedDate,
                  onDateChange: (newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                    _loadDataForDate(newDate);
                  },
                ),
                SizedBox(height: 16),
                if (isLoading)
                  Container(
                    color: Colors.white.withOpacity(0.5),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (!isLoading)
                  Expanded(
                    child: PinterestGridViewBuilder(
                      sleepData: sleepData,
                      workoutDataList: workoutData,
                      emotionDataList: emotionData,
                      incomeExpenseDataList: incomeExpenses,
                      foodDataList: foodData, // 🍽️ 음식 데이터 전달
                      logRecord: logRecord, // 📝 오늘의 한줄 전달
                      icons: icons,
                      sleepService: _sleepService,
                      workoutService: _workoutService,
                      emotionService: _emotionService,
                      incomeExpenseService: _incomeExpenseService,
                      foodService: _foodService, // 🍽️ 음식 서비스 전달
                      selectedDate: selectedDate,
                      onUpdateSleep: _updateSleepData,
                      onUpdateWorkout: _updateWorkoutData,
                      onUpdateEmotion: _updateEmotionData,
                      onUpdateIncomeExpense: _updateIncomeExpenseData,
                      onUpdateFood: _updateFoodData, // 🍽️ 음식 업데이트 함수 추가
                      onUpdateLog: _saveLog, // 📝 오늘의 한줄 업데이트 함수 추가
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFFAEDFF7),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: S.of(context).analytics,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: S.of(context).settings,
          ),
        ],
      ),
    );
  }
}
