import 'package:assignments/src/components/tasks_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../cubits/course_cubit/course_cubit.dart';
import '../../cubits/courses_cubit/courses_cubit.dart';
import '../../cubits/tasks_cubit/tasks_cubit.dart';
import '../../models/course_model.dart';
import '../../models/task_model.dart';
import '../../routes/config_routes.dart';
import 'course_dialog.dart';

class CourseDetailsScreen extends StatelessWidget {
  static const routeName = '/courses/:id';

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
    );
  }
}
