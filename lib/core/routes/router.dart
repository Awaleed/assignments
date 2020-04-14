import 'package:assignments/features/assignments/presentation/pages/assignment/assignment_dialog.dart';
import 'package:assignments/features/assignments/presentation/pages/course/course_details.dart';
import 'package:assignments/features/assignments/presentation/pages/course/course_dialog.dart';
import 'package:auto_route/auto_route_annotations.dart';

import '../../features/assignments/presentation/pages/assignment/assignment_details.dart';

import '../../pages/home_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomePage homePage;
  CourseDetails courseDetails;
  @MaterialRoute(fullscreenDialog: true)
  CourseDialog courseDialog;

  AssignmentDetails assignmentDetails;
  @MaterialRoute(fullscreenDialog: true)
  AssignmentDialog assignmentDialog;
}
