// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../features/settings/settings_widgets.dart';
import '../../features/tasks/domain/entities/course_entity.dart';
import '../../features/tasks/domain/entities/task_entity.dart';
import '../../features/tasks/presentation/pages/calendar/calendar.dart';
import '../../features/tasks/presentation/pages/course/course_details.dart';
import '../../features/tasks/presentation/pages/course/course_dialog.dart';
import '../../features/tasks/presentation/pages/course/courses_page.dart';
import '../../features/tasks/presentation/pages/task/task_details.dart';
import '../../features/tasks/presentation/pages/task/task_dialog.dart';
import '../../features/tasks/presentation/pages/task/tasks_page.dart';

class Routes {
  static const String tasksPage = '/';
  static const String coursesPage = '/courses-page';
  static const String courseDetails = '/course-details';
  static const String courseDialog = '/course-dialog';
  static const String taskDialog = '/task-dialog';
  static const String taskDetails = '/task-details';
  static const String settingsExample = '/settings-example';
  static const String calendarPage = '/calendar-page';
  static const all = <String>{
    tasksPage,
    coursesPage,
    courseDetails,
    courseDialog,
    taskDialog,
    taskDetails,
    settingsExample,
    calendarPage,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.tasksPage, page: TasksPage),
    RouteDef(Routes.coursesPage, page: CoursesPage),
    RouteDef(Routes.courseDetails, page: CourseDetails),
    RouteDef(Routes.courseDialog, page: CourseDialog),
    RouteDef(Routes.taskDialog, page: TaskDialog),
    RouteDef(Routes.taskDetails, page: TaskDetails),
    RouteDef(Routes.settingsExample, page: SettingsExample),
    RouteDef(Routes.calendarPage, page: CalendarPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    TasksPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const TasksPage(),
        settings: data,
      );
    },
    CoursesPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CoursesPage(),
        settings: data,
      );
    },
    CourseDetails: (data) {
      final args = data.getArgs<CourseDetailsArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CourseDetails(
          key: args.key,
          course: args.course,
        ),
        settings: data,
      );
    },
    CourseDialog: (data) {
      final args = data.getArgs<CourseDialogArguments>(nullOk: false);
      return MaterialPageRoute<Course>(
        builder: (context) => CourseDialog(
          key: args.key,
          course: args.course,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    TaskDialog: (data) {
      final args = data.getArgs<TaskDialogArguments>(nullOk: false);
      return MaterialPageRoute<Task>(
        builder: (context) => TaskDialog(
          args.task,
          key: args.key,
          fixedCourse: args.fixedCourse,
          fixedDate: args.fixedDate,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    TaskDetails: (data) {
      final args = data.getArgs<TaskDetailsArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => TaskDetails(
          args.task,
          key: args.key,
          parent: args.parent,
        ),
        settings: data,
      );
    },
    SettingsExample: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsExample(),
        settings: data,
      );
    },
    CalendarPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CalendarPage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// CourseDetails arguments holder class
class CourseDetailsArguments {
  final Key key;
  final Course course;
  CourseDetailsArguments({this.key, @required this.course});
}

/// CourseDialog arguments holder class
class CourseDialogArguments {
  final Key key;
  final Course course;
  CourseDialogArguments({this.key, @required this.course});
}

/// TaskDialog arguments holder class
class TaskDialogArguments {
  final Task task;
  final Key key;
  final bool fixedCourse;
  final bool fixedDate;
  TaskDialogArguments(
      {@required this.task,
      this.key,
      this.fixedCourse = false,
      this.fixedDate = false});
}

/// TaskDetails arguments holder class
class TaskDetailsArguments {
  final Task task;
  final Key key;
  final Task parent;
  TaskDetailsArguments({@required this.task, this.key, @required this.parent});
}
