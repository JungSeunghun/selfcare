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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("추가"),
        "addSleepRecord": MessageLookupByLibrary.simpleMessage("새로운 수면 기록 추가"),
        "analytics": MessageLookupByLibrary.simpleMessage("분석"),
        "cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "dateHeader_month": m0,
        "dateHeader_today": MessageLookupByLibrary.simpleMessage("오늘"),
        "dateHeader_year": m1,
        "editSleepRecord": MessageLookupByLibrary.simpleMessage("수면 기록 수정"),
        "home": MessageLookupByLibrary.simpleMessage("홈"),
        "hours": MessageLookupByLibrary.simpleMessage("시간"),
        "minutes": MessageLookupByLibrary.simpleMessage("분"),
        "noWorkoutMessage": MessageLookupByLibrary.simpleMessage(
            "오늘은 어떤 운동을 했나요? 🏋️\n작은 움직임이 큰 변화를 만듭니다! 💪"),
        "save": MessageLookupByLibrary.simpleMessage("저장"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "sleep": MessageLookupByLibrary.simpleMessage("수면"),
        "sleepMessage": MessageLookupByLibrary.simpleMessage(
            "오늘은 얼마나 푹 잤나요? 💤\n따뜻한 하루 되세요! 🌞"),
        "sleepTimeLabel": MessageLookupByLibrary.simpleMessage("잤는 시간"),
        "totalWorkoutDuration": MessageLookupByLibrary.simpleMessage("총 운동 시간"),
        "wakeTimeLabel": MessageLookupByLibrary.simpleMessage("일어난 시간"),
        "workout": MessageLookupByLibrary.simpleMessage("운동")
      };
}
