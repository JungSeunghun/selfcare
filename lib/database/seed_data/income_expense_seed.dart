import 'package:sqflite/sqflite.dart';

class IncomeExpenseSeed {
  static Future<void> insertDefaultData(Database db) async {
    // 수입/지출 기본 타입 데이터
    const defaultTypes = {
      'en': {
        'income': ['Salary', 'Bonus', 'Investment', 'Gift', 'Freelance'],
        'expense': ['Rent', 'Groceries', 'Transportation', 'Utilities', 'Entertainment', 'Dining Out', 'Shopping', 'Insurance']
      },
      'ko': {
        'income': ['급여', '보너스', '투자', '선물', '프리랜서'],
        'expense': ['임대료', '식료품', '교통비', '공과금', '오락', '외식', '쇼핑', '보험']
      }
    };

    // 데이터 삽입
    for (var locale in defaultTypes.keys) {
      for (var category in defaultTypes[locale]!.keys) {
        for (var type in defaultTypes[locale]![category]!) {
          await db.insert('income_expense_types', {
            'name': type,
            'locale': locale,
            'category': category,
          });
        }
      }
    }
  }
}
