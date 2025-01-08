import 'package:selfcare/database/seed_data/food_seed.dart';
import 'package:selfcare/database/seed_data/income_expense_seed.dart';
import 'package:selfcare/database/tables/food_table.dart';
import 'package:selfcare/database/tables/income_expense_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'tables/workout_table.dart';
import 'tables/sleep_table.dart';
import 'tables/emotion_table.dart';
import 'seed_data/workout_seed.dart';
import 'seed_data/emotion_seed.dart';

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
      version: 1,
      onCreate: (db, version) async {
        // 테이블 생성
        await WorkoutTable.create(db);
        await SleepTable.create(db);
        await EmotionTable.create(db);
        await IncomeExpenseTypeTable.create(db);
        await FoodTable.create(db);

        // 기본 데이터 삽입
        await WorkoutSeed.insertDefaultData(db);
        await EmotionSeed.insertDefaultData(db);
        await IncomeExpenseSeed.insertDefaultData(db);
        await FoodSeed.insertDefaultData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
      },
    );
  }
}
