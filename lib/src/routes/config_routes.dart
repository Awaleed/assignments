<<<<<<< Updated upstream
import 'package:assignments/init_injectable.dart';
import 'package:assignments/src/cubits/course_cubit/course_cubit.dart';
import 'package:assignments/src/cubits/task_cubit/task_cubit.dart';
import 'package:assignments/src/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:assignments/src/models/course_model.dart';
import 'package:assignments/src/models/task_model.dart';
import 'package:assignments/src/screens/calendar/calendar.dart';
import 'package:assignments/src/screens/course/course_details.dart';
import 'package:assignments/src/screens/course/course_dialog.dart';
import 'package:assignments/src/screens/course/courses_screen.dart';
import 'package:assignments/src/screens/playground/playground.dart';
import 'package:assignments/src/screens/settings/settings_screen.dart';
import 'package:assignments/src/screens/task/task_details.dart';
import 'package:assignments/src/screens/task/task_dialog.dart';
import 'package:assignments/src/screens/task/tasks_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../patched_components/sailor/sailor.dart';
import '../screens/main/main.dart';
=======
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
>>>>>>> Stashed changes

abstract class AppRouter {
  static final sailor = Sailor(
    options: const SailorOptions(handleNameNotFoundUI: true),
  );

  static void createRoutes() {
    sailor.addRoutes(
      [
<<<<<<< Updated upstream
        _simpleBuilder(PlaygroundScreen.routeName, const PlaygroundScreen()),
        _simpleBuilder(MainScreen.routeName, MainScreen()),

        _simpleBuilder(
          TasksScreen.routeName,
          BlocProvider(
=======
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
>>>>>>> Stashed changes
            create: (context) => getIt<TasksCubit>()..getAllTasks(),
            child: const TasksScreen(),
          ),
        ),
<<<<<<< Updated upstream

        SailorRoute(
          name: TaskDetailsScreen.routeName,
          params: [SailorParam(name: 'task')],
          builder: (context, args, paramMap) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<TaskCubit>(param1: paramMap.param<TaskModel>('task')),
              ),
              BlocProvider(create: (context) => getIt<TasksCubit>()),
            ],
            child: const TaskDetailsScreen(),
          ),
        ),

        SailorRoute(
          name: TaskDialog.routeName,
          params: [SailorParam(name: 'task')],
          builder: (context, args, paramMap) {
            if (paramMap.param('task') != null) {
              return BlocProvider<TaskCubit>(
                create: (context) => getIt<TaskCubit>(param1: paramMap.param('task')),
                child: const TaskDialog(),
              );
            } else {
              return BlocProvider<TaskCubit>(
                create: (context) => getIt<TaskCubit>(param1: TaskModel()),
                child: const TaskDialog(),
              );
            }
          },
        ),

        _simpleBuilder(CoursesScreen.routeName, const CoursesScreen()),
        SailorRoute(
          name: CourseDetailsScreen.routeName,
          params: [SailorParam(name: 'course')],
          builder: (context, args, paramMap) => MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      getIt<CourseCubit>(param1: paramMap.param<CourseModel>('course'))),
              BlocProvider(
                  create: (context) =>
                      getIt<TasksCubit>()..getCourseTasks(paramMap.param<CourseModel>('course')!)),
            ],
            child: const CourseDetailsScreen(),
=======
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
>>>>>>> Stashed changes
          ),
        ),
        SailorRoute(
          name: CourseDialog.routeName,
<<<<<<< Updated upstream
          params: [SailorParam(name: 'course_cubit')],
          builder: (context, args, paramMap) {
            if (paramMap.param('course_cubit') != null) {
              return BlocProvider<CourseCubit>.value(
                value: paramMap.param('course_cubit'),
                child: const CourseDialog(),
              );
            } else {
              return BlocProvider<CourseCubit>(
                create: (context) => getIt<CourseCubit>(param1: CourseModel()),
                child: const CourseDialog(),
              );
            }
          },
        ),

        _simpleBuilder(
          CalendarScreen.routeName,
          BlocProvider(
            create: (context) => getIt<TasksCubit>()..getAllTasks(),
            child: const CalendarScreen(),
          ),
        ),
        _simpleBuilder(SettingsScreen.routeName, const SettingsScreen()),

        // SailorRoute(
        //   name: OnboardingScreen.routeName,
        //   builder: (context, args, paramMap) => const OnboardingScreen(),
        // ),

        // /// Tasks Screens
        // SailorRoute(
        //   name: TasksScreen.routeName,
        //   builder: (context, args, paramMap) => BlocProvider(
        //     create: (context) => getIt<TasksCubit>()..getAllTasks(),
        //     child: const TasksScreen(),
        //   ),
        // ),
        // SailorRoute(
        //   name: TaskDetailsScreen.routeName,
        //   params: [
        //     SailorParam(name: 'task'),
        //     SailorParam(name: 'parentTask'),
        //   ],
        //   builder: (context, args, paramMap) => BlocProvider(
        //     create: (context) => getIt<TasksCubit>(),
        //     child: TaskDetailsScreen(
        //       task: paramMap.param('task'),
        //       parentTask: paramMap.param('parentTask'),
        //     ),
        //   ),
        // ),
        // SailorRoute(
        //   name: TaskDialog.routeName,
        //   params: [
        //     SailorParam(name: 'task'),
        //     SailorParam(name: 'date'),
        //     SailorParam(name: 'course'),
        //   ],
        //   builder: (context, args, paramMap) => BlocProvider(
        //     create: (context) => getIt<TasksCubit>(),
        //     child: TaskDialog(task: paramMap.param('task')),
        //   ),
        // ),

        // /// Courses Screens
        // SailorRoute(
        //   name: CoursesScreen.routeName,
        //   builder: (context, args, paramMap) => const CoursesScreen(),
        // ),
        // SailorRoute(
        //   name: CourseDetailsScreen.routeName,
        //   params: [
        //     SailorParam(name: 'course'),
        //   ],
        //   builder: (context, args, paramMap) => BlocProvider(
        //     create: (context) => getIt<TasksCubit>()
        //       ..getCourseTasks(
        //         paramMap.param<CourseModel>('course')!.id,
        //       ),
        //     child: CourseDetailsScreen(course: paramMap.param('course')),
        //   ),
        // ),
        // SailorRoute(
        //   name: CourseDialog.routeName,
        //   params: [SailorParam(name: 'course')],
        //   builder: (context, args, paramMap) => CourseDialog(
        //     course: paramMap.param('course'),
        //   ),
        // ),

        // /// Courses Screens
        // SailorRoute(
        //   name: CalendarScreen.routeName,
        //   builder: (context, args, paramMap) => const CalendarScreen(),
        // ),

        // /// Settings Screens
        // SailorRoute(
        //   name: SettingsScreen.routeName,
        //   builder: (context, args, paramMap) => const SettingsScreen(),
        // ),
      ],
    );
  }

  static SailorRoute _simpleBuilder(routeName, screen, [params]) =>
      SailorRoute(name: routeName, builder: (_, __, ___) => screen, params: params);
=======
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
>>>>>>> Stashed changes
}
