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

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: TasksPage, initial: true),
    MaterialRoute(page: CoursesPage),
    MaterialRoute(page: CourseDetails),
    MaterialRoute<Course>(page: CourseDialog, fullscreenDialog: true),
    MaterialRoute<Task>(page: TaskDialog, fullscreenDialog: true),
    MaterialRoute(page: TaskDetails),
    MaterialRoute(page: SettingsExample),
    MaterialRoute(page: CalendarPage),
  ],
)
class $AppRouter {}
