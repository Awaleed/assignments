import 'package:assignments/src/screens/signin/signin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';

import '../../init_injectable.dart';
import '../cubits/courses_cubit/courses_cubit.dart';
import '../cubits/settings_cubit/settings_cubit.dart';
import '../cubits/tasks_cubit/tasks_cubit.dart';
import '../models/course_model.dart';
import '../screens/calendar/calendar.dart';
import '../screens/course/course_details.dart';
import '../screens/course/course_dialog.dart';
import '../screens/course/courses_screen.dart';
import '../screens/onboarding.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/splash.dart';
import '../screens/task/task_details.dart';
import '../screens/task/task_dialog.dart';
import '../screens/task/tasks_screen.dart';

abstract class AppRouter {
  static final sailor = Sailor(
    options: const SailorOptions(handleNameNotFoundUI: true),
  );

  static void createRoutes() {
    sailor.addRoutes(
      [
        /// Pre Login
        SailorRoute(
          name: SplashScreen.routeName,
          builder: (context, args, paramMap) => const SplashScreen(),
        ),
        SailorRoute(
          name: OnboardingScreen.routeName,
          builder: (context, args, paramMap) => const OnboardingScreen(),
        ),
        // SailorRoute(
        //   name: SignInScreen.routeName,
        //   builder: (context, args, paramMap) => const SignInScreen(),
        // ),

        /// Tasks Screens
        SailorRoute(
          name: TasksScreen.routeName,
          builder: (context, args, paramMap) => BlocProvider(
            create: (context) => getIt<TasksCubit>()..getAllTasks(),
            child: const TasksScreen(),
          ),
        ),
        SailorRoute(
          name: TaskDetailsScreen.routeName,
          params: [
            SailorParam(name: 'task', isRequired: true),
            SailorParam(name: 'parentTask'),
          ],
          builder: (context, args, paramMap) => BlocProvider(
            create: (context) => getIt<TasksCubit>(),
            child: TaskDetailsScreen(
              task: paramMap.param('task'),
              parentTask: paramMap.param('parentTask'),
            ),
          ),
        ),
        SailorRoute(
          name: TaskDialog.routeName,
          params: [
            SailorParam(name: 'task'),
            SailorParam(name: 'date'),
            SailorParam(name: 'course'),
          ],
          builder: (context, args, paramMap) => MultiBlocProvider(
            providers: [
              BlocProvider<CoursesCubit>(
                create: (context) => getIt<CoursesCubit>()..getAllCourses(),
              ),
              BlocProvider<TasksCubit>(
                create: (context) => getIt<TasksCubit>(),
              ),
            ],
            child: TaskDialog(
              task: paramMap.param('task'),
            ),
          ),
        ),

        /// Courses Screens
        SailorRoute(
          name: CoursesScreen.routeName,
          builder: (context, args, paramMap) => BlocProvider(
            create: (context) => getIt<CoursesCubit>()..getAllCourses(),
            child: const CoursesScreen(),
          ),
        ),
        SailorRoute(
          name: CourseDetailsScreen.routeName,
          params: [
            SailorParam(name: 'course', isRequired: true),
          ],
          builder: (context, args, paramMap) => MultiBlocProvider(
            providers: [
              BlocProvider<CoursesCubit>(
                create: (context) => getIt<CoursesCubit>(),
              ),
              BlocProvider<TasksCubit>(
                create: (context) => getIt<TasksCubit>()..getCourseTasks(paramMap.param<CourseModel>('course').id),
              ),
            ],
            child: CourseDetailsScreen(
              course: paramMap.param('course'),
            ),
          ),
        ),
        SailorRoute(
          name: CourseDialog.routeName,
          params: [
            SailorParam(name: 'course'),
          ],
          builder: (context, args, paramMap) => BlocProvider(
            create: (context) => getIt<CoursesCubit>(),
            child: CourseDialog(
              course: paramMap.param('course'),
            ),
          ),
        ),

        /// Courses Screens
        SailorRoute(
          name: CalendarScreen.routeName,
          builder: (context, args, paramMap) => BlocProvider(
            create: (context) => getIt<CoursesCubit>()..getAllCourses(),
            child: const CalendarScreen(),
          ),
        ),

        /// Settings Screens
        SailorRoute(
          name: SettingsScreen.routeName,
          builder: (context, args, paramMap) => BlocProvider.value(
            value: getIt<SettingsCubit>(),
            child: const SettingsScreen(),
          ),
        ),
      ],
    );
  }
}
