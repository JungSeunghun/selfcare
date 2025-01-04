import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'selfcare.db');

    return await openDatabase(
      path,
      version: 5, // DB 버전 업데이트
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE workouts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            workoutType TEXT,
            duration INTEGER,
            date TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE sleep (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sleepTime TEXT,
            wakeTime TEXT,
            totalSleepDuration TEXT,
            date TEXT
          )
        ''');

        // workout_types 테이블 생성
        await db.execute('''
          CREATE TABLE workout_types (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            locale TEXT NOT NULL
          )
        ''');

        // 기본 workout_types 삽입
        await _insertDefaultWorkoutTypes(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {
          // workout_types 테이블 생성
          await db.execute('''
            CREATE TABLE IF NOT EXISTS workout_types (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              locale TEXT NOT NULL
            )
          ''');

          // 기본 workout_types 삽입
          await _insertDefaultWorkoutTypes(db);
        }
      },
    );
  }

  /// 기본 workout_types 삽입
  Future<void> _insertDefaultWorkoutTypes(Database db) async {
    const defaultTypes = {
      'en': ['Running', 'Cycling', 'Yoga', 'Weight Training', 'Swimming', 'Tennis', 'Pilates', 'Soccer', 'Basketball'],
      'ko': ['러닝', '자전거 타기', '요가', '웨이트 트레이닝', '수영', '테니스', '필라테스', '축구', '농구'],
    };

    for (var locale in defaultTypes.keys) {
      for (var type in defaultTypes[locale]!) {
        await db.insert('workout_types', {'name': type, 'locale': locale});
      }
    }
  }
}
