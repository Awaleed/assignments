import 'package:flutter/material.dart';

import '../../../../core/utils.dart';
import '../../domain/entities/task_entity.dart';
import '../store/tasks.dart';
import 'tasks_list_view.dart';

@immutable
class TasksTabView extends StatelessWidget {
  final List<Task> upcoming;
  final List<Task> overdue;
  final TabController tabController;
  final VoidCallback onAddTask;
  const TasksTabView({
    Key key,
    @required this.tabController,
    @required this.upcoming,
    @required this.overdue,
    @required this.onAddTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: [
      _buildTasksTabView(context, VisibilityFilter.upcoming),
      _buildTasksTabView(context, VisibilityFilter.overdue),
    ]);
  }

  Widget _buildTasksTabView(BuildContext context, VisibilityFilter type) {
    final loc = localeBase(context);
    final tasks = type == VisibilityFilter.upcoming ? upcoming : overdue;
    return Scaffold(
      body: tasks.isEmpty
          ? Center(child: Text(loc.tasks.empty_tasks_list))
          : TasksListView(parent: null, tasks: tasks),
      floatingActionButton: type == VisibilityFilter.upcoming
          ? FloatingActionButton.extended(
              onPressed: onAddTask,
              label: Text(loc.tasks.new_task),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }

  // Future _refresh(context) {
  //   Scaffold.of(context)
  //       .showSnackBar(SnackBar(content: Text('fetching data...')));
  //   return Future.delayed(Duration(milliseconds: 500));
  // }
}
