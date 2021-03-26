import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/course_model.dart';
import '../models/task_model.dart';
import '../routes/config_routes.dart';
import '../screens/task/task_dialog.dart';
import 'tasks_list_view.dart';

@immutable
class TasksTabView extends StatelessWidget {
  const TasksTabView({
    Key key,
    @required this.tasks,
    this.course,
    this.date,
  }) : super(key: key);

  final List<TaskModel> tasks;
  final CourseModel course;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        _buildTasksTabView(context, upcoming: true),
        _buildTasksTabView(context, upcoming: false),
      ],
    );
  }

  Widget _buildTasksTabView(BuildContext context, {bool upcoming}) {
    final values = tasks.where((task) => task.isDue == !upcoming).toList();

    return Scaffold(
      body: values.isEmpty ? Center(child: Text(S.current.empty_tasks_list)) : TasksListView(tasks: values),
      floatingActionButton: upcoming
          ? FloatingActionButton.extended(
              onPressed: () {
                AppRouter.sailor.navigate(
                  TaskDialog.routeName,
                  params: {'task': TaskModel(dueDate: date, course: course)},
                );
              },
              label: Text(S.current.new_task),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }
}
