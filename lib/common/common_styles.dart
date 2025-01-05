import 'package:flutter/material.dart';

class CommonStyles {
  // 카드 스타일
  static BoxDecoration cardDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFAEDFF7), Color(0xFFF9F9F9)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(16.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8.0,
        offset: Offset(2, 4),
      ),
    ],
  );

  // 다이얼로그 스타일
  static RoundedRectangleBorder dialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  );

  // 텍스트 스타일
  static TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static TextStyle largeTextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static TextStyle smallTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );
}
