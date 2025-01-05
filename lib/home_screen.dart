import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'generated/l10n.dart';
import 'components/pinterest_grid_view_builder.dart';
import 'components/date_header.dart';
import 'services/sleep_service.dart';
import 'services/workout_service.dart';
import 'services/emotion_service.dart';
import 'services/income_expense_service.dart';
import 'models/sleep_record_model.dart';
import 'models/workout_record_model.dart';
import 'models/emotion_model.dart';
import 'models/income_expense_model.dart';
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
  };

  final SleepService _sleepService = SleepService();
  final WorkoutService _workoutService = WorkoutService();
  final EmotionService _emotionService = EmotionService();
  final IncomeExpenseService _incomeExpenseService = IncomeExpenseService();

  String selectedDate = DateFormat('yMd').format(DateTime.now());
  SleepRecord? sleepData;
  List<WorkoutRecord> workoutData = [];
  List<Emotion> emotionData = [];
  List<IncomeExpenseModel> incomeExpenses = [];
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

    setState(() {
      sleepData = sleepRecord;
      workoutData = workouts;
      emotionData = emotions;
      incomeExpenses = expenses;
      isLoading = false;
    });
  }

  void _updateSleepData(SleepRecord updatedRecord) {
    setState(() {
      sleepData = updatedRecord;
    });
  }

  void _updateWorkoutData(List<WorkoutRecord> updatedRecords) {
    setState(() {
      workoutData = updatedRecords;
    });
  }

  void _updateEmotionData(List<Emotion> updatedRecords) {
    setState(() {
      emotionData = updatedRecords;
    });
  }

  void _updateIncomeExpenseData(List<IncomeExpenseModel> updatedRecords) {
    setState(() {
      incomeExpenses = updatedRecords;
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
                Expanded(
                  child: sleepData != null
                      ? PinterestGridViewBuilder(
                    sleepData: sleepData!,
                    workoutDataList: workoutData,
                    emotionDataList: emotionData,
                    incomeExpenseDataList: incomeExpenses,
                    icons: icons,
                    sleepService: _sleepService,
                    workoutService: _workoutService,
                    emotionService: _emotionService,
                    incomeExpenseService: _incomeExpenseService,
                    selectedDate: selectedDate,
                    onUpdateSleep: _updateSleepData,
                    onUpdateWorkout: _updateWorkoutData,
                    onUpdateEmotion: _updateEmotionData,
                    onUpdateIncomeExpense: _updateIncomeExpenseData,
                  )
                      : Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
            if (isLoading)
              Container(
                color: Colors.white.withOpacity(0.5),
                child: Center(child: CircularProgressIndicator()),
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
