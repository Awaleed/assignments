// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:assignments/pages/home_page.dart';
import 'package:assignments/features/assignments/presentation/pages/class/class_details.dart';
import 'package:assignments/features/assignments/domain/entities/class_entity.dart';
import 'package:assignments/features/assignments/presentation/pages/class/class_dialog.dart';
import 'package:assignments/features/assignments/presentation/pages/assignment/assignment_details.dart';
import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:assignments/features/assignments/presentation/pages/assignment/assignment_dialog.dart';

abstract class Routes {
  static const homePage = '/';
  static const classDetails = '/class-details';
  static const classDialog = '/class-dialog';
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
      case Routes.classDetails:
        if (hasInvalidArgs<ClassDetailsArguments>(args)) {
          return misTypedArgsRoute<ClassDetailsArguments>(args);
        }
        final typedArgs =
            args as ClassDetailsArguments ?? ClassDetailsArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => ClassDetails(
              key: typedArgs.key,
              entity: typedArgs.entity,
              onEdit: typedArgs.onEdit,
              onDelete: typedArgs.onDelete),
          settings: settings,
        );
      case Routes.classDialog:
        if (hasInvalidArgs<ClassDialogArguments>(args)) {
          return misTypedArgsRoute<ClassDialogArguments>(args);
        }
        final typedArgs =
            args as ClassDialogArguments ?? ClassDialogArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => ClassDialog(
              key: typedArgs.key, classEntity: typedArgs.classEntity),
          settings: settings,
          fullscreenDialog: true,
        );
      case Routes.assignmentDetails:
        if (hasInvalidArgs<AssignmentDetailsArguments>(args)) {
          return misTypedArgsRoute<AssignmentDetailsArguments>(args);
        }
        final typedArgs =
            args as AssignmentDetailsArguments ?? AssignmentDetailsArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => AssignmentDetails(
              key: typedArgs.key,
              entity: typedArgs.entity,
              onEdit: typedArgs.onEdit,
              onDelete: typedArgs.onDelete),
          settings: settings,
        );
      case Routes.assignmentDialog:
        if (hasInvalidArgs<AssignmentDialogArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<AssignmentDialogArguments>(args);
        }
        final typedArgs = args as AssignmentDialogArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => AssignmentDialog(
              key: typedArgs.key,
              classList: typedArgs.classList,
              assignment: typedArgs.assignment),
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

//ClassDetails arguments holder class
class ClassDetailsArguments {
  final Key key;
  final ClassEntity entity;
  final Function onEdit;
  final Function onDelete;
  ClassDetailsArguments({this.key, this.entity, this.onEdit, this.onDelete});
}

//ClassDialog arguments holder class
class ClassDialogArguments {
  final Key key;
  final ClassEntity classEntity;
  ClassDialogArguments({this.key, this.classEntity});
}

//AssignmentDetails arguments holder class
class AssignmentDetailsArguments {
  final Key key;
  final AssignmentEntity entity;
  final Function onEdit;
  final Function onDelete;
  AssignmentDetailsArguments(
      {this.key, this.entity, this.onEdit, this.onDelete});
}

//AssignmentDialog arguments holder class
class AssignmentDialogArguments {
  final Key key;
  final List<ClassEntity> classList;
  final AssignmentEntity assignment;
  AssignmentDialogArguments(
      {this.key, @required this.classList, this.assignment});
}
