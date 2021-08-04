import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../helpers/formatters.dart';
import '../models/task_model.dart';
import '../routes/config_routes.dart';
import '../screens/task/task_details.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  const TaskTile(
    this.task, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TaskModel>(
      valueListenable: task.listenable,
      builder: (context, value, child) {
        return Card(
          child: InkWell(
            onTap: () => AppRouter.sailor.navigate(
              TaskDetailsScreen.routeName,
              params: {'task': task},
            ),
            child: Row(
              children: <Widget>[
                if (!task.isSubTask)
                  Container(
                    height: 100,
                    width: 7,
                    decoration: BoxDecoration(
                      color: task?.course?.color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              task.title,
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                    decoration: task.progress == 100 ? TextDecoration.lineThrough : null,
                                  ),
                            ),
                            Text(
                              '${task.progress.toInt()}%',
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                    decoration: task.progress == 100 ? TextDecoration.lineThrough : null,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Helpers.mapTaskType(type: task.type, loc: loc)',
                              style: Theme.of(context).textTheme.caption.copyWith(
                                    decoration: task.progress == 100 ? TextDecoration.lineThrough : null,
                                  ),
                            ),
                            Text(
                              Formatters.taskTime(task.dueDate),
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                    decoration: task.progress == 100 ? TextDecoration.lineThrough : null,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              task.isSubTask ? '' : task?.course?.title,
                              style: Theme.of(context).textTheme.caption.copyWith(
                                    decoration: task.progress == 100 ? TextDecoration.lineThrough : null,
                                  ),
                            ),
                            Text(
                              task.isSubTask ? '' : '${S.current.subtasks} ${task.subtasks?.length ?? 0}',
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                    decoration: task.progress == 100 ? TextDecoration.lineThrough : null,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
