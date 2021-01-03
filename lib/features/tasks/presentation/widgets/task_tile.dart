import 'package:flutter/material.dart';

import '../../../../core/utils.dart';
import '../../domain/entities/task_entity.dart';
import '../helpers.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  const TaskTile(
    this.task, {
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = localeBase(context);
    return Card(
      child: InkWell(
        onTap: onTap,
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
                                decoration: task.progress == 100
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                        ),
                        Text(
                          '${task.progress.toInt()}%',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                decoration: task.progress == 100
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          Helpers.mapTaskType(type: task.type, loc: loc),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                decoration: task.progress == 100
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                        ),
                        Text(
                          taskTimeFormatter(context).format(task.dueDate),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                decoration: task.progress == 100
                                    ? TextDecoration.lineThrough
                                    : null,
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
                                decoration: task.progress == 100
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                        ),
                        Text(
                          task.isSubTask
                              ? ''
                              : '${loc.tasks.subtasks} ${task.subtasks.length}',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                decoration: task.progress == 100
                                    ? TextDecoration.lineThrough
                                    : null,
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
  }
}
