// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:assignments/pages/home_page.dart';
import 'package:assignments/features/assignments/presentation/pages/course/course_details.dart';
import 'package:assignments/features/assignments/domain/entities/course_entity.dart';
import 'package:assignments/features/assignments/presentation/pages/course/course_dialog.dart';
import 'package:assignments/features/assignments/presentation/pages/assignment/assignment_details.dart';
import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:assignments/features/assignments/presentation/pages/assignment/assignment_dialog.dart';

abstract class Routes {
  static const homePage = '/';
  static const courseDetails = '/course-details';
  static const courseDialog = '/course-dialog';
  static const assignmentDetails = '/assignment-details';
  static const assignmentDialog = '/assignment-dialog';
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
      case Routes.homePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(),
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
        if (hasInvalidArgs<CourseDialogArguments>(args)) {
          return misTypedArgsRoute<CourseDialogArguments>(args);
        }
        final typedArgs =
            args as CourseDialogArguments ?? CourseDialogArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              CourseDialog(key: typedArgs.key, course: typedArgs.course),
          settings: settings,
          fullscreenDialog: true,
        );
      case Routes.assignmentDetails:
        if (hasInvalidArgs<AssignmentDetailsArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<AssignmentDetailsArguments>(args);
        }
        final typedArgs = args as AssignmentDetailsArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => AssignmentDetails(
              key: typedArgs.key, assignment: typedArgs.assignment),
          settings: settings,
        );
      case Routes.assignmentDialog:
        if (hasInvalidArgs<AssignmentDialogArguments>(args)) {
          return misTypedArgsRoute<AssignmentDialogArguments>(args);
        }
        final typedArgs =
            args as AssignmentDialogArguments ?? AssignmentDialogArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => AssignmentDialog(
              key: typedArgs.key, assignment: typedArgs.assignment),
          settings: settings,
          fullscreenDialog: true,
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
  final CourseEntity course;
  CourseDetailsArguments({this.key, @required this.course});
}

//CourseDialog arguments holder class
class CourseDialogArguments {
  final Key key;
  final CourseEntity course;
  CourseDialogArguments({this.key, this.course});
}

//AssignmentDetails arguments holder class
class AssignmentDetailsArguments {
  final Key key;
  final AssignmentEntity assignment;
  AssignmentDetailsArguments({this.key, @required this.assignment});
}

//AssignmentDialog arguments holder class
class AssignmentDialogArguments {
  final Key key;
  final AssignmentEntity assignment;
  AssignmentDialogArguments({this.key, this.assignment});
}
