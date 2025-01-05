class IncomeExpenseModel {
  int? id;
  String type; // 'income' or 'expense'
  double amount;
  String? description;
  String date;
  int? typeId;

  IncomeExpenseModel({
    this.id,
    required this.type,
    required this.amount,
    this.description,
    required this.date,
    this.typeId,
  });

  // 데이터베이스에서 객체로 변환
  factory IncomeExpenseModel.fromMap(Map<String, dynamic> map) {
    return IncomeExpenseModel(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      description: map['description'],
      date: map['date'],
      typeId: map['typeId'],
    );
  }

  // 객체를 데이터베이스에 삽입할 수 있도록 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'description': description,
      'date': date,
      'typeId': typeId,
    };
  }

  // copyWith 메서드 추가
  IncomeExpenseModel copyWith({
    int? id,
    String? type,
    double? amount,
    String? description,
    String? date,
    int? typeId,
  }) {
    return IncomeExpenseModel(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      typeId: typeId ?? this.typeId,
    );
  }
}
