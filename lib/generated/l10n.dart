// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get analytics {
    return Intl.message(
      'Analytics',
      name: 'analytics',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Sleep`
  String get sleep {
    return Intl.message(
      'Sleep',
      name: 'sleep',
      desc: '',
      args: [],
    );
  }

  /// `Workout`
  String get workout {
    return Intl.message(
      'Workout',
      name: 'workout',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get dateHeader_today {
    return Intl.message(
      'Today',
      name: 'dateHeader_today',
      desc: '',
      args: [],
    );
  }

  /// `{month}`
  String dateHeader_month(Object month) {
    return Intl.message(
      '$month',
      name: 'dateHeader_month',
      desc: '',
      args: [month],
    );
  }

  /// `{year}`
  String dateHeader_year(Object year) {
    return Intl.message(
      '$year',
      name: 'dateHeader_year',
      desc: '',
      args: [year],
    );
  }

  /// `How well did you sleep today? 💤\nHave a warm day! 🌞`
  String get sleepMessage {
    return Intl.message(
      'How well did you sleep today? 💤\nHave a warm day! 🌞',
      name: 'sleepMessage',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get hours {
    return Intl.message(
      'h',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get minutes {
    return Intl.message(
      'm',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Add New Sleep Record`
  String get addSleepRecord {
    return Intl.message(
      'Add New Sleep Record',
      name: 'addSleepRecord',
      desc: '',
      args: [],
    );
  }

  /// `Edit Sleep Record`
  String get editSleepRecord {
    return Intl.message(
      'Edit Sleep Record',
      name: 'editSleepRecord',
      desc: '',
      args: [],
    );
  }

  /// `Sleep Time`
  String get sleepTimeLabel {
    return Intl.message(
      'Sleep Time',
      name: 'sleepTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Wake Time`
  String get wakeTimeLabel {
    return Intl.message(
      'Wake Time',
      name: 'wakeTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `What kind of workout did you do today? 🏋️\nSmall movements lead to big changes! 💪`
  String get noWorkoutMessage {
    return Intl.message(
      'What kind of workout did you do today? 🏋️\nSmall movements lead to big changes! 💪',
      name: 'noWorkoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `Total Workout Duration`
  String get totalWorkoutDuration {
    return Intl.message(
      'Total Workout Duration',
      name: 'totalWorkoutDuration',
      desc: '',
      args: [],
    );
  }

  /// `Edit Workout Record`
  String get editWorkoutRecord {
    return Intl.message(
      'Edit Workout Record',
      name: 'editWorkoutRecord',
      desc: '',
      args: [],
    );
  }

  /// `Select Workout Type`
  String get workoutTypeSelect {
    return Intl.message(
      'Select Workout Type',
      name: 'workoutTypeSelect',
      desc: '',
      args: [],
    );
  }

  /// `Add New Workout Type`
  String get addWorkoutType {
    return Intl.message(
      'Add New Workout Type',
      name: 'addWorkoutType',
      desc: '',
      args: [],
    );
  }

  /// `Workout Record Input`
  String get workoutRecordInput {
    return Intl.message(
      'Workout Record Input',
      name: 'workoutRecordInput',
      desc: '',
      args: [],
    );
  }

  /// `Duration (minutes)`
  String get durationInMinutes {
    return Intl.message(
      'Duration (minutes)',
      name: 'durationInMinutes',
      desc: '',
      args: [],
    );
  }

  /// `Workout Type Management`
  String get workoutTypeManagement {
    return Intl.message(
      'Workout Type Management',
      name: 'workoutTypeManagement',
      desc: '',
      args: [],
    );
  }

  /// `No workout types available.`
  String get noWorkoutTypes {
    return Intl.message(
      'No workout types available.',
      name: 'noWorkoutTypes',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new workout type`
  String get addNewWorkoutTypeHint {
    return Intl.message(
      'Enter a new workout type',
      name: 'addNewWorkoutTypeHint',
      desc: '',
      args: [],
    );
  }

  /// `Edit workout type`
  String get editWorkoutTypeHint {
    return Intl.message(
      'Edit workout type',
      name: 'editWorkoutTypeHint',
      desc: '',
      args: [],
    );
  }

  /// `Delete Confirmation`
  String get deleteConfirmation {
    return Intl.message(
      'Delete Confirmation',
      name: 'deleteConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete {type}?`
  String deleteWorkoutTypeConfirmation(Object type) {
    return Intl.message(
      'Are you sure you want to delete $type?',
      name: 'deleteWorkoutTypeConfirmation',
      desc: '',
      args: [type],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Emotion`
  String get emotion {
    return Intl.message(
      'Emotion',
      name: 'emotion',
      desc: '',
      args: [],
    );
  }

  /// `How are you feeling today? 😊\nTake a moment to reflect and care for yourself. 💙`
  String get emotionMessage {
    return Intl.message(
      'How are you feeling today? 😊\nTake a moment to reflect and care for yourself. 💙',
      name: 'emotionMessage',
      desc: '',
      args: [],
    );
  }

  /// `points`
  String get intensityLabel {
    return Intl.message(
      'points',
      name: 'intensityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit Emotion Record`
  String get editEmotionRecord {
    return Intl.message(
      'Edit Emotion Record',
      name: 'editEmotionRecord',
      desc: '',
      args: [],
    );
  }

  /// `Select Emotion Type`
  String get emotionTypeSelect {
    return Intl.message(
      'Select Emotion Type',
      name: 'emotionTypeSelect',
      desc: '',
      args: [],
    );
  }

  /// `Emotion Record Input`
  String get emotionRecordInput {
    return Intl.message(
      'Emotion Record Input',
      name: 'emotionRecordInput',
      desc: '',
      args: [],
    );
  }

  /// `Emotion Type Management`
  String get emotionTypeManagement {
    return Intl.message(
      'Emotion Type Management',
      name: 'emotionTypeManagement',
      desc: '',
      args: [],
    );
  }

  /// `No emotion types available.`
  String get noEmotionTypes {
    return Intl.message(
      'No emotion types available.',
      name: 'noEmotionTypes',
      desc: '',
      args: [],
    );
  }

  /// `Add New Emotion Type`
  String get addEmotionType {
    return Intl.message(
      'Add New Emotion Type',
      name: 'addEmotionType',
      desc: '',
      args: [],
    );
  }

  /// `Edit Emotion Type`
  String get editEmotionTypeHint {
    return Intl.message(
      'Edit Emotion Type',
      name: 'editEmotionTypeHint',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete {type}?`
  String deleteEmotionTypeConfirmation(Object type) {
    return Intl.message(
      'Are you sure you want to delete $type?',
      name: 'deleteEmotionTypeConfirmation',
      desc: '',
      args: [type],
    );
  }

  /// `Income/Expense`
  String get income_expense {
    return Intl.message(
      'Income/Expense',
      name: 'income_expense',
      desc: '',
      args: [],
    );
  }

  /// `No income or expense records available.`
  String get noIncomeExpenseMessage {
    return Intl.message(
      'No income or expense records available.',
      name: 'noIncomeExpenseMessage',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalIncomeExpense {
    return Intl.message(
      'Total Amount',
      name: 'totalIncomeExpense',
      desc: '',
      args: [],
    );
  }

  /// `Edit Income/Expense Record`
  String get editIncomeExpenseRecord {
    return Intl.message(
      'Edit Income/Expense Record',
      name: 'editIncomeExpenseRecord',
      desc: '',
      args: [],
    );
  }

  /// `Add Income`
  String get addIncome {
    return Intl.message(
      'Add Income',
      name: 'addIncome',
      desc: '',
      args: [],
    );
  }

  /// `Add Expense`
  String get addExpense {
    return Intl.message(
      'Add Expense',
      name: 'addExpense',
      desc: '',
      args: [],
    );
  }

  /// `Enter Amount`
  String get enterAmount {
    return Intl.message(
      'Enter Amount',
      name: 'enterAmount',
      desc: '',
      args: [],
    );
  }

  /// `USD`
  String get currency {
    return Intl.message(
      'USD',
      name: 'currency',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
