<<<<<<< Updated upstream
import 'package:assignments/src/components/tasks_tab_view.dart';
=======
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
<<<<<<< Updated upstream
import '../../cubits/course_cubit/course_cubit.dart';
import '../../cubits/courses_cubit/courses_cubit.dart';
import '../../cubits/tasks_cubit/tasks_cubit.dart';
import '../../models/course_model.dart';
import '../../models/task_model.dart';
=======
import '../../components/tasks_tab_view.dart';
import '../../cubits/courses_cubit/courses_cubit.dart';
import '../../cubits/tasks_cubit/tasks_cubit.dart';
import '../../models/course_model.dart';
>>>>>>> Stashed changes
import '../../routes/config_routes.dart';
import 'course_dialog.dart';

class CourseDetailsScreen extends StatelessWidget {
  static const routeName = '/courses/:id';

<<<<<<< Updated upstream
  const CourseDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseModel>(
      builder: (context, course) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(text: S.current.upcoming.toUpperCase()),
                  Tab(text: S.current.overdue.toUpperCase())
                ],
              ),
              title: Text(course.title!),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<CoursesCubit>().deleteCourse(course);
                    AppRouter.sailor.pop();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    AppRouter.sailor.navigate(
                      CourseDialog.routeName,
                      params: {'course_cubit': context.read<CourseCubit>()},
                    );
                  },
                )
              ],
            ),
            body: BlocBuilder<TasksCubit, List<TaskModel>>(
              builder: (context, tasks) => TasksTabView(tasks: tasks, course: course),
            ),
          ),
        );
      },
=======
  const CourseDetailsScreen({
    Key key,
    @required this.course,
  }) : super(key: key);

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: TabBar(
            tabs: [Tab(text: S.current.upcoming.toUpperCase()), Tab(text: S.current.overdue.toUpperCase())],
          ),
          title: Text(course.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await context.read<CoursesCubit>().deleteCourse(course.id);
                context.read<CoursesCubit>().state.maybeWhen(
                      deleted: () => AppRouter.sailor.pop(),
                      orElse: () => null,
                    );
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                AppRouter.sailor.navigate(
                  CourseDialog.routeName,
                  params: {'course': course},
                );
              },
            )
          ],
        ),
        body: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            return state.when(
              // TODO use other values
              initial: () => const Placeholder(),
              updated: () => const Placeholder(),
              created: () => const Placeholder(),
              loading: () => const Placeholder(),
              loaded: (values) => TasksTabView(tasks: values, course: course),
              failure: (_) => const Placeholder(),
            );
          },
        ),
      ),
>>>>>>> Stashed changes
    );
  }
}
