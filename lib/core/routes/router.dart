import 'package:auto_route/auto_route_annotations.dart';

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

@MaterialAutoRouter()
class $Router {
  CoursesPage coursesPage;
  CourseDetails courseDetails;
  @MaterialRoute(fullscreenDialog: true, returnType: Course)
  CourseDialog courseDialog;

  @initial
  TasksPage tasksPage;
  TaskDetails taskDetails;
  @MaterialRoute(fullscreenDialog: true, returnType: Task)
  TaskDialog taskDialog;

  SettingsExample settingsPage;
  // DevelopmentPage developmentPage;
  CalendarPage calendarPage;
}
