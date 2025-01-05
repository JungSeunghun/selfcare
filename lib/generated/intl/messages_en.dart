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

  static String m2(type) => "Are you sure you want to delete ${type}?";

  static String m3(type) => "Are you sure you want to delete ${type}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addEmotionType":
            MessageLookupByLibrary.simpleMessage("Add New Emotion Type"),
        "addExpense": MessageLookupByLibrary.simpleMessage("Add Expense"),
        "addIncome": MessageLookupByLibrary.simpleMessage("Add Income"),
        "addNewWorkoutTypeHint":
            MessageLookupByLibrary.simpleMessage("Enter a new workout type"),
        "addSleepRecord":
            MessageLookupByLibrary.simpleMessage("Add New Sleep Record"),
        "addWorkoutType":
            MessageLookupByLibrary.simpleMessage("Add New Workout Type"),
        "analytics": MessageLookupByLibrary.simpleMessage("Analytics"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "currency": MessageLookupByLibrary.simpleMessage("USD"),
        "dateHeader_month": m0,
        "dateHeader_today": MessageLookupByLibrary.simpleMessage("Today"),
        "dateHeader_year": m1,
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteConfirmation":
            MessageLookupByLibrary.simpleMessage("Delete Confirmation"),
        "deleteEmotionTypeConfirmation": m2,
        "deleteWorkoutTypeConfirmation": m3,
        "durationInMinutes":
            MessageLookupByLibrary.simpleMessage("Duration (minutes)"),
        "editEmotionRecord":
            MessageLookupByLibrary.simpleMessage("Edit Emotion Record"),
        "editEmotionTypeHint":
            MessageLookupByLibrary.simpleMessage("Edit Emotion Type"),
        "editIncomeExpenseRecord":
            MessageLookupByLibrary.simpleMessage("Edit Income/Expense Record"),
        "editSleepRecord":
            MessageLookupByLibrary.simpleMessage("Edit Sleep Record"),
        "editWorkoutRecord":
            MessageLookupByLibrary.simpleMessage("Edit Workout Record"),
        "editWorkoutTypeHint":
            MessageLookupByLibrary.simpleMessage("Edit workout type"),
        "emotion": MessageLookupByLibrary.simpleMessage("Emotion"),
        "emotionMessage": MessageLookupByLibrary.simpleMessage(
            "How are you feeling today? 😊\nTake a moment to reflect and care for yourself. 💙"),
        "emotionRecordInput":
            MessageLookupByLibrary.simpleMessage("Emotion Record Input"),
        "emotionTypeManagement":
            MessageLookupByLibrary.simpleMessage("Emotion Type Management"),
        "emotionTypeSelect":
            MessageLookupByLibrary.simpleMessage("Select Emotion Type"),
        "enterAmount": MessageLookupByLibrary.simpleMessage("Enter Amount"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "hours": MessageLookupByLibrary.simpleMessage("h"),
        "income_expense":
            MessageLookupByLibrary.simpleMessage("Income/Expense"),
        "intensityLabel": MessageLookupByLibrary.simpleMessage("points"),
        "minutes": MessageLookupByLibrary.simpleMessage("m"),
        "noEmotionTypes":
            MessageLookupByLibrary.simpleMessage("No emotion types available."),
        "noIncomeExpenseMessage": MessageLookupByLibrary.simpleMessage(
            "No income or expense records available."),
        "noWorkoutMessage": MessageLookupByLibrary.simpleMessage(
            "What kind of workout did you do today? 🏋️\nSmall movements lead to big changes! 💪"),
        "noWorkoutTypes":
            MessageLookupByLibrary.simpleMessage("No workout types available."),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sleep": MessageLookupByLibrary.simpleMessage("Sleep"),
        "sleepMessage": MessageLookupByLibrary.simpleMessage(
            "How well did you sleep today? 💤\nHave a warm day! 🌞"),
        "sleepTimeLabel": MessageLookupByLibrary.simpleMessage("Sleep Time"),
        "totalIncomeExpense":
            MessageLookupByLibrary.simpleMessage("Total Amount"),
        "totalWorkoutDuration":
            MessageLookupByLibrary.simpleMessage("Total Workout Duration"),
        "wakeTimeLabel": MessageLookupByLibrary.simpleMessage("Wake Time"),
        "workout": MessageLookupByLibrary.simpleMessage("Workout"),
        "workoutRecordInput":
            MessageLookupByLibrary.simpleMessage("Workout Record Input"),
        "workoutTypeManagement":
            MessageLookupByLibrary.simpleMessage("Workout Type Management"),
        "workoutTypeSelect":
            MessageLookupByLibrary.simpleMessage("Select Workout Type")
      };
}
