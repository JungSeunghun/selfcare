// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(month) => "${month}";

  static String m1(year) => "${year}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addSleepRecord":
            MessageLookupByLibrary.simpleMessage("Add New Sleep Record"),
        "analytics": MessageLookupByLibrary.simpleMessage("Analytics"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "dateHeader_month": m0,
        "dateHeader_today": MessageLookupByLibrary.simpleMessage("Today"),
        "dateHeader_year": m1,
        "editSleepRecord":
            MessageLookupByLibrary.simpleMessage("Edit Sleep Record"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "hours": MessageLookupByLibrary.simpleMessage("h"),
        "minutes": MessageLookupByLibrary.simpleMessage("m"),
        "noWorkoutMessage": MessageLookupByLibrary.simpleMessage(
            "What kind of workout did you do today? 🏋️\nSmall movements lead to big changes! 💪"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sleep": MessageLookupByLibrary.simpleMessage("Sleep"),
        "sleepMessage": MessageLookupByLibrary.simpleMessage(
            "How well did you sleep today? 💤\nHave a warm day! 🌞"),
        "sleepTimeLabel": MessageLookupByLibrary.simpleMessage("Sleep Time"),
        "totalWorkoutDuration":
            MessageLookupByLibrary.simpleMessage("Total Workout Duration"),
        "wakeTimeLabel": MessageLookupByLibrary.simpleMessage("Wake Time"),
        "workout": MessageLookupByLibrary.simpleMessage("Workout")
      };
}
