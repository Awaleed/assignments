import 'package:assignments/features/assignments/presentation/pages/assignment/assignment_dialog.dart';
import 'package:auto_route/auto_route_annotations.dart';

import '../../features/assignments/presentation/pages/assignment/assignment_details.dart';
import '../../features/assignments/presentation/pages/class/class_details.dart';
import '../../features/assignments/presentation/pages/class/class_dialog.dart';
import '../../pages/home_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomePage homePage;
  ClassDetails classDetails;
  @MaterialRoute(fullscreenDialog: true)
  ClassDialog classDialog;

  AssignmentDetails assignmentDetails;
  @MaterialRoute(fullscreenDialog: true)
  AssignmentDialog assignmentDialog;
}
