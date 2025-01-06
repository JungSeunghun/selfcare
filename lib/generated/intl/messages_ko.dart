// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  static String m0(month) => "${month}";

  static String m1(year) => "${year}년";

  static String m2(type) => "${type}을(를) 삭제하시겠습니까?";

  static String m3(type) => "${type}을(를) 삭제하시겠습니까?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("추가"),
        "addEmotionType": MessageLookupByLibrary.simpleMessage("새로운 감정 유형 추가"),
        "addExpense": MessageLookupByLibrary.simpleMessage("지출 추가"),
        "addExpenseType": MessageLookupByLibrary.simpleMessage("지출 유형 추가"),
        "addIncome": MessageLookupByLibrary.simpleMessage("수입 추가"),
        "addIncomeExpenseType": MessageLookupByLibrary.simpleMessage("새 유형 추가"),
        "addIncomeType": MessageLookupByLibrary.simpleMessage("수입 유형 추가"),
        "addNewWorkoutTypeHint":
            MessageLookupByLibrary.simpleMessage("새 운동 타입 입력"),
        "addSleepRecord": MessageLookupByLibrary.simpleMessage("새로운 수면 기록 추가"),
        "addWorkoutType": MessageLookupByLibrary.simpleMessage("새로운 운동 타입 추가"),
        "analytics": MessageLookupByLibrary.simpleMessage("분석"),
        "cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "close": MessageLookupByLibrary.simpleMessage("닫기"),
        "currency": MessageLookupByLibrary.simpleMessage("원"),
        "dateHeader_month": m0,
        "dateHeader_today": MessageLookupByLibrary.simpleMessage("오늘"),
        "dateHeader_year": m1,
        "delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "deleteConfirmation": MessageLookupByLibrary.simpleMessage("삭제 확인"),
        "deleteEmotionTypeConfirmation": m2,
        "deleteIncomeExpenseTypeConfirmation":
            MessageLookupByLibrary.simpleMessage("이 유형을 삭제하시겠습니까?"),
        "deleteWorkoutTypeConfirmation": m3,
        "durationInMinutes": MessageLookupByLibrary.simpleMessage("시간 (분)"),
        "editEmotionRecord": MessageLookupByLibrary.simpleMessage("감정 기록 수정"),
        "editEmotionTypeHint": MessageLookupByLibrary.simpleMessage("감정 유형 수정"),
        "editExpenseTypeHint": MessageLookupByLibrary.simpleMessage("지출 유형 편집"),
        "editIncomeExpenseRecord":
            MessageLookupByLibrary.simpleMessage("수입/지출 기록 편집"),
        "editIncomeExpenseTypeHint":
            MessageLookupByLibrary.simpleMessage("유형 이름 편집"),
        "editIncomeTypeHint": MessageLookupByLibrary.simpleMessage("수입 유형 편집"),
        "editSleepRecord": MessageLookupByLibrary.simpleMessage("수면 기록 수정"),
        "editWorkoutRecord": MessageLookupByLibrary.simpleMessage("운동 기록 수정"),
        "editWorkoutTypeHint": MessageLookupByLibrary.simpleMessage("운동 타입 수정"),
        "emotion": MessageLookupByLibrary.simpleMessage("감정"),
        "emotionMessage": MessageLookupByLibrary.simpleMessage(
            "오늘은 기분이\n어떤가요? 😊\n스스로를 돌보는 따뜻한 시간을 가져보세요. 💙"),
        "emotionRecordInput": MessageLookupByLibrary.simpleMessage("감정 기록 입력"),
        "emotionTypeManagement":
            MessageLookupByLibrary.simpleMessage("감정 유형 관리"),
        "emotionTypeSelect": MessageLookupByLibrary.simpleMessage("감정 타입 선택"),
        "enterAmount": MessageLookupByLibrary.simpleMessage("금액 입력"),
        "home": MessageLookupByLibrary.simpleMessage("홈"),
        "hours": MessageLookupByLibrary.simpleMessage("시간"),
        "incomeExpenseTypeManagement":
            MessageLookupByLibrary.simpleMessage("수입/지출 유형 관리"),
        "incomeExpenseTypeSelect":
            MessageLookupByLibrary.simpleMessage("수입 또는 지출 유형을 선택하세요"),
        "income_expense": MessageLookupByLibrary.simpleMessage("수입/지출"),
        "intensityLabel": MessageLookupByLibrary.simpleMessage("점"),
        "manageExpenseTypes": MessageLookupByLibrary.simpleMessage("지출 유형 관리"),
        "manageIncomeTypes": MessageLookupByLibrary.simpleMessage("수입 유형 관리"),
        "minutes": MessageLookupByLibrary.simpleMessage("분"),
        "noEmotionTypes":
            MessageLookupByLibrary.simpleMessage("사용 가능한 감정 유형이 없습니다."),
        "noExpenseTypes":
            MessageLookupByLibrary.simpleMessage("등록된 지출 유형이 없습니다."),
        "noIncomeExpenseMessage": MessageLookupByLibrary.simpleMessage(
            "수입과 지출을 기록하며 목표를 향해 나아가요! 🚀\n작은 습관이 큰 성과로 이어집니다. 🌟"),
        "noIncomeExpenseTypes":
            MessageLookupByLibrary.simpleMessage("등록된 수입/지출 유형이 없습니다."),
        "noIncomeTypes":
            MessageLookupByLibrary.simpleMessage("등록된 수입 유형이 없습니다."),
        "noWorkoutMessage": MessageLookupByLibrary.simpleMessage(
            "오늘은 어떤 운동을\n했나요? 🏋️\n작은 움직임이 큰\n변화를 만듭니다! 💪"),
        "noWorkoutTypes": MessageLookupByLibrary.simpleMessage("운동 타입이 없습니다."),
        "save": MessageLookupByLibrary.simpleMessage("저장"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "sleep": MessageLookupByLibrary.simpleMessage("수면"),
        "sleepMessage": MessageLookupByLibrary.simpleMessage(
            "오늘은 얼마나\n푹 잤나요? 💤\n따뜻한 하루 되세요! 🌞"),
        "sleepTimeLabel": MessageLookupByLibrary.simpleMessage("잤는 시간"),
        "totalExpense": MessageLookupByLibrary.simpleMessage("총 지출"),
        "totalIncome": MessageLookupByLibrary.simpleMessage("총 수입"),
        "totalIncomeExpense": MessageLookupByLibrary.simpleMessage("총 금액"),
        "totalWorkoutDuration": MessageLookupByLibrary.simpleMessage("총 운동 시간"),
        "unknown": MessageLookupByLibrary.simpleMessage("알 수 없음"),
        "wakeTimeLabel": MessageLookupByLibrary.simpleMessage("일어난 시간"),
        "workout": MessageLookupByLibrary.simpleMessage("운동"),
        "workoutRecordInput": MessageLookupByLibrary.simpleMessage("운동 기록 입력"),
        "workoutTypeManagement":
            MessageLookupByLibrary.simpleMessage("운동 타입 관리"),
        "workoutTypeSelect": MessageLookupByLibrary.simpleMessage("운동 타입 선택")
      };
}
