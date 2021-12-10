import 'package:flutter/material.dart';

import '../models/task_model.dart';
import 'date_tile.dart';
import 'task_tile.dart';

class TasksListView extends StatelessWidget {
<<<<<<< Updated upstream
  const TasksListView({
    Key? key,
    required this.tasks,
    this.header,
  }) : super(key: key);

  final List<TaskModel> tasks;
  final List<Widget>? header;

=======
  final List<TaskModel> tasks;
  final TaskModel parentTask;
  final List<Widget> header;

  const TasksListView({
    Key key,
    this.tasks,
    this.header,
    this.parentTask,
  }) : super(key: key);

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    final widgets = _buildChildren();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
    );
  }

  List<Widget> _buildChildren() {
    final taskItems = <Widget>[];
    if (header != null) {
<<<<<<< Updated upstream
      taskItems.addAll(header!);
    }
    int index = 0;
    DateTime previousDate;
    if (tasks.isNotEmpty) {
      previousDate = tasks.first.dueDate!.dateOnly;
=======
      taskItems.addAll(header);
    }
    int index = 0;
    DateTime previousDate;
    if (tasks != null && tasks.isNotEmpty) {
      previousDate = tasks.first.dueDate.dateOnly;
>>>>>>> Stashed changes
      taskItems.add(DateTile(previousDate));

      while (index < tasks.length) {
        final task = tasks[index];
<<<<<<< Updated upstream
        final currentDate = task.dueDate!.dateOnly;
=======
        final currentDate = task.dueDate.dateOnly;
>>>>>>> Stashed changes
        final taskTile = TaskTile(task);

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

extension on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);
}
