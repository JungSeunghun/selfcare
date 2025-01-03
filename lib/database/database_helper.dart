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
      version: 3, // Increment the database version
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

        await db.execute('''
          CREATE TABLE workout_types (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');

        // Insert default workout types
        await _insertDefaultWorkoutTypes(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE workouts ADD COLUMN date TEXT');
          await db.execute('ALTER TABLE sleep ADD COLUMN date TEXT');
        }
        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE workout_types (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL
            )
          ''');

          await _insertDefaultWorkoutTypes(db);
        }
      },
    );
  }

  Future<void> _insertDefaultWorkoutTypes(Database db) async {
    const defaultTypes = [
      '러닝',
      '자전거 타기',
      '요가',
      '웨이트 트레이닝',
      '수영',
    ];

    for (String type in defaultTypes) {
      await db.insert('workout_types', {'name': type});
    }
  }
}
