// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:assignments/features/tasks/presentation/pages/course/courses_page.dart';
import 'package:assignments/features/tasks/presentation/pages/course/course_details.dart';
import 'package:assignments/features/tasks/domain/entities/course_entity.dart';
import 'package:assignments/features/tasks/presentation/pages/course/course_dialog.dart';
import 'package:assignments/features/tasks/presentation/pages/task/tasks_page.dart';
import 'package:assignments/features/tasks/presentation/pages/task/task_details.dart';
import 'package:assignments/features/tasks/domain/entities/task_entity.dart';
import 'package:assignments/features/tasks/presentation/pages/task/task_dialog.dart';
import 'package:assignments/features/settings/settings_widgets.dart';
import 'package:assignments/features/tasks/presentation/pages/calendar/calendar.dart';

abstract class Routes {
  static const coursesPage = '/courses-page';
  static const courseDetails = '/course-details';
  static const courseDialog = '/course-dialog';
  static const tasksPage = '/';
  static const taskDetails = '/task-details';
  static const taskDialog = '/task-dialog';
  static const settingsPage = '/settings-page';
  static const calendarPage = '/calendar-page';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.coursesPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => CoursesPage(),
          settings: settings,
        );
      case Routes.courseDetails:
        if (hasInvalidArgs<CourseDetailsArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<CourseDetailsArguments>(args);
        }
        final typedArgs = args as CourseDetailsArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              CourseDetails(key: typedArgs.key, course: typedArgs.course),
          settings: settings,
        );
      case Routes.courseDialog:
        if (hasInvalidArgs<CourseDialogArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<CourseDialogArguments>(args);
        }
        final typedArgs = args as CourseDialogArguments;
        return MaterialPageRoute<Course>(
          builder: (_) =>
              CourseDialog(key: typedArgs.key, course: typedArgs.course),
          settings: settings,
          fullscreenDialog: true,
        );
      case Routes.tasksPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => TasksPage(),
          settings: settings,
        );
      case Routes.taskDetails:
        if (hasInvalidArgs<TaskDetailsArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<TaskDetailsArguments>(args);
        }
        final typedArgs = args as TaskDetailsArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => TaskDetails(typedArgs.task,
              key: typedArgs.key, parent: typedArgs.parent),
          settings: settings,
        );
      case Routes.taskDialog:
        if (hasInvalidArgs<TaskDialogArguments>(args)) {
          return misTypedArgsRoute<TaskDialogArguments>(args);
        }
        final typedArgs = args as TaskDialogArguments ?? TaskDialogArguments();
        return MaterialPageRoute<Task>(
          builder: (_) => TaskDialog(typedArgs.task,
              key: typedArgs.key,
              fixedCourse: typedArgs.fixedCourse,
              fixedDate: typedArgs.fixedDate),
          settings: settings,
          fullscreenDialog: true,
        );
      case Routes.settingsPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SettingsExample(),
          settings: settings,
        );
      case Routes.calendarPage:
        if (hasInvalidArgs<CalendarPageArguments>(args)) {
          return misTypedArgsRoute<CalendarPageArguments>(args);
        }
        final typedArgs =
            args as CalendarPageArguments ?? CalendarPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => CalendarPage(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//CourseDetails arguments holder class
class CourseDetailsArguments {
  final Key key;
  final Course course;
  CourseDetailsArguments({this.key, @required this.course});
}

//CourseDialog arguments holder class
class CourseDialogArguments {
  final Key key;
  final Course course;
  CourseDialogArguments({this.key, @required this.course});
}

//TaskDetails arguments holder class
class TaskDetailsArguments {
  final Task task;
  final Key key;
  final Task parent;
  TaskDetailsArguments({this.task, this.key, @required this.parent});
}

//TaskDialog arguments holder class
class TaskDialogArguments {
  final Task task;
  final Key key;
  final bool fixedCourse;
  final bool fixedDate;
  TaskDialogArguments(
      {this.task, this.key, this.fixedCourse = false, this.fixedDate = false});
}

//CalendarPage arguments holder class
class CalendarPageArguments {
  final Key key;
  CalendarPageArguments({this.key});
}
