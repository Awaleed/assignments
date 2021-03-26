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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get an_error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Tap back again to leave`
  String get tap_back_again_to_leave {
    return Intl.message(
      'Tap back again to leave',
      name: 'tap_back_again_to_leave',
      desc: '',
      args: [],
    );
  }

  /// `at`
  String get at {
    return Intl.message(
      'at',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get auto {
    return Intl.message(
      'Auto',
      name: 'auto',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Course color`
  String get course_color {
    return Intl.message(
      'Course color',
      name: 'course_color',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get courses {
    return Intl.message(
      'Courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Course title`
  String get course_title {
    return Intl.message(
      'Course title',
      name: 'course_title',
      desc: '',
      args: [],
    );
  }

  /// `Due`
  String get due_date {
    return Intl.message(
      'Due',
      name: 'due_date',
      desc: '',
      args: [],
    );
  }

  /// `Editing`
  String get editing {
    return Intl.message(
      'Editing',
      name: 'editing',
      desc: '',
      args: [],
    );
  }

  /// `Please add new course`
  String get empty_courses_error {
    return Intl.message(
      'Please add new course',
      name: 'empty_courses_error',
      desc: '',
      args: [],
    );
  }

  /// `There is no courses to show, Add some...`
  String get empty_courses_list {
    return Intl.message(
      'There is no courses to show, Add some...',
      name: 'empty_courses_list',
      desc: '',
      args: [],
    );
  }

  /// `Task name can't be empty`
  String get empty_name_error_message {
    return Intl.message(
      'Task name can\'t be empty',
      name: 'empty_name_error_message',
      desc: '',
      args: [],
    );
  }

  /// `There is no tasks to show, Add some...`
  String get empty_tasks_list {
    return Intl.message(
      'There is no tasks to show, Add some...',
      name: 'empty_tasks_list',
      desc: '',
      args: [],
    );
  }

  /// `Title can't be empty`
  String get empty_title_error_message {
    return Intl.message(
      'Title can\'t be empty',
      name: 'empty_title_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Homework`
  String get homework {
    return Intl.message(
      'Homework',
      name: 'homework',
      desc: '',
      args: [],
    );
  }

  /// `New course`
  String get new_course {
    return Intl.message(
      'New course',
      name: 'new_course',
      desc: '',
      args: [],
    );
  }

  /// `New subtask`
  String get new_subtask {
    return Intl.message(
      'New subtask',
      name: 'new_subtask',
      desc: '',
      args: [],
    );
  }

  /// `New task`
  String get new_task {
    return Intl.message(
      'New task',
      name: 'new_task',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `overdue`
  String get overdue {
    return Intl.message(
      'overdue',
      name: 'overdue',
      desc: '',
      args: [],
    );
  }

  /// `has it all ready due?`
  String get overdue_error_message {
    return Intl.message(
      'has it all ready due?',
      name: 'overdue_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message(
      'Progress',
      name: 'progress',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get project {
    return Intl.message(
      'Project',
      name: 'project',
      desc: '',
      args: [],
    );
  }

  /// `Quiz`
  String get quiz {
    return Intl.message(
      'Quiz',
      name: 'quiz',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `Remind you after it's already due?`
  String get reminder_date_error_message {
    return Intl.message(
      'Remind you after it\'s already due?',
      name: 'reminder_date_error_message',
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

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Task name must be longer than 2 characters`
  String get short_name_error_message {
    return Intl.message(
      'Task name must be longer than 2 characters',
      name: 'short_name_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Title must be longer than 2 characters`
  String get short_title_error_message {
    return Intl.message(
      'Title must be longer than 2 characters',
      name: 'short_title_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Subtasks`
  String get subtasks {
    return Intl.message(
      'Subtasks',
      name: 'subtasks',
      desc: '',
      args: [],
    );
  }

  /// `Task name`
  String get task_name {
    return Intl.message(
      'Task name',
      name: 'task_name',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get test {
    return Intl.message(
      'Test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `upcoming`
  String get upcoming {
    return Intl.message(
      'upcoming',
      name: 'upcoming',
      desc: '',
      args: [],
    );
  }

  /// `Use dark mode`
  String get use_dark_mode {
    return Intl.message(
      'Use dark mode',
      name: 'use_dark_mode',
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
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}