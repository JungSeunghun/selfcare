import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'components/pinterest_grid_view_builder.dart';
import 'components/date_header.dart';
import 'services/sleep_service.dart';
import 'services/workout_service.dart';
import 'models/sleep_record_model.dart';
import 'models/workout_record_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, IconData> icons = {
    "수면": Ionicons.bed_outline,
    "운동": Ionicons.fitness_outline,
  };

  final SleepService _sleepService = SleepService();
  final WorkoutService _workoutService = WorkoutService();

  String selectedDate = DateFormat('yMd').format(DateTime.now());
  SleepRecord? sleepData;
  List<WorkoutRecord> workoutData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDataForDate(selectedDate);
  }

  /// 날짜에 따른 데이터 로드
  Future<void> _loadDataForDate(String date) async {
    setState(() {
      isLoading = true; // 로딩 시작
    });

    final sleepRecord = await _sleepService.getSleepRecordByDate(date);
    final workouts = await _workoutService.getWorkoutsByDate(date);

    setState(() {
      sleepData = sleepRecord;
      workoutData = workouts;
      isLoading = false; // 로딩 완료
    });
  }

  /// 수면 데이터 업데이트
  void _updateSleepData(SleepRecord updatedRecord) {
    setState(() {
      sleepData = updatedRecord;
    });
  }

  /// 운동 데이터 업데이트
  void _updateWorkoutData(List<WorkoutRecord> updatedRecords) {
    setState(() {
      workoutData = updatedRecords;
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
                    icons: icons,
                    sleepService: _sleepService,
                    workoutService: _workoutService,
                    selectedDate: selectedDate,
                    onUpdateSleep: _updateSleepData,
                    onUpdateWorkout: _updateWorkoutData,
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: '분석',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
