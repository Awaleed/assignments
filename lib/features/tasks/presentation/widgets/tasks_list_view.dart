import 'package:flutter/material.dart';

import '../../domain/entities/task_entity.dart';
import '../helpers.dart';
import 'date_tile.dart';
import 'task_tile.dart';

class TasksListView extends StatelessWidget {
  final List<Task> tasks;
  final Task parent;
  final List<Widget> header;

  const TasksListView({
    Key key,
    this.tasks,
    this.header,
    @required this.parent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // itemCount: ,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    final taskItems = <Widget>[];
    if (header != null) {
      taskItems.addAll(header);
    }
    int index = 0;
    DateTime previousDate;
    if (tasks != null && tasks.isNotEmpty) {
      previousDate = DateTime(
        tasks[0].dueDate.year,
        tasks[0].dueDate.month,
        tasks[0].dueDate.day,
      );

      taskItems.add(DateTile(previousDate));

      while (index < tasks.length) {
        final task = tasks[index];
        final currentDate = DateTime(
          task.dueDate.year,
          task.dueDate.month,
          task.dueDate.day,
        );
        final taskTile = TaskTile(
          task,
          onTap: () => Helpers.onShowTaskDetails(parent: parent, task: task),
        );

        if (currentDate.isAfter(previousDate)) {
          previousDate = currentDate;
          taskItems..add(DateTile(currentDate))..add(taskTile);
        } else {
          taskItems.add(taskTile);
        }
        index++;
      }
    }

    return taskItems;
  }
}
