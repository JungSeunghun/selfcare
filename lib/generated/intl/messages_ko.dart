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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("추가"),
        "addNewWorkoutTypeHint":
            MessageLookupByLibrary.simpleMessage("새 운동 타입 입력"),
        "addSleepRecord": MessageLookupByLibrary.simpleMessage("새로운 수면 기록 추가"),
        "addWorkoutType": MessageLookupByLibrary.simpleMessage("운동 타입 추가"),
        "analytics": MessageLookupByLibrary.simpleMessage("분석"),
        "cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "close": MessageLookupByLibrary.simpleMessage("닫기"),
        "dateHeader_month": m0,
        "dateHeader_today": MessageLookupByLibrary.simpleMessage("오늘"),
        "dateHeader_year": m1,
        "delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "deleteConfirmation": MessageLookupByLibrary.simpleMessage("삭제 확인"),
        "deleteWorkoutTypeConfirmation": m2,
        "durationInMinutes": MessageLookupByLibrary.simpleMessage("시간 (분)"),
        "editSleepRecord": MessageLookupByLibrary.simpleMessage("수면 기록 수정"),
        "editWorkoutRecord": MessageLookupByLibrary.simpleMessage("운동 기록 수정"),
        "editWorkoutTypeHint": MessageLookupByLibrary.simpleMessage("운동 타입 수정"),
        "home": MessageLookupByLibrary.simpleMessage("홈"),
        "hours": MessageLookupByLibrary.simpleMessage("시간"),
        "minutes": MessageLookupByLibrary.simpleMessage("분"),
        "noWorkoutMessage": MessageLookupByLibrary.simpleMessage(
            "오늘은 어떤 운동을\n했나요? 🏋️\n작은 움직임이 큰\n변화를 만듭니다! 💪"),
        "noWorkoutTypes": MessageLookupByLibrary.simpleMessage("운동 타입이 없습니다."),
        "save": MessageLookupByLibrary.simpleMessage("저장"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "sleep": MessageLookupByLibrary.simpleMessage("수면"),
        "sleepMessage": MessageLookupByLibrary.simpleMessage(
            "오늘은 얼마나\n푹 잤나요? 💤\n따뜻한 하루 되세요! 🌞"),
        "sleepTimeLabel": MessageLookupByLibrary.simpleMessage("잤는 시간"),
        "totalWorkoutDuration": MessageLookupByLibrary.simpleMessage("총 운동 시간"),
        "wakeTimeLabel": MessageLookupByLibrary.simpleMessage("일어난 시간"),
        "workout": MessageLookupByLibrary.simpleMessage("운동"),
        "workoutRecordInput": MessageLookupByLibrary.simpleMessage("운동 기록 입력"),
        "workoutTypeManagement":
            MessageLookupByLibrary.simpleMessage("운동 타입 관리"),
        "workoutTypeSelect": MessageLookupByLibrary.simpleMessage("운동 타입 선택")
      };
}
