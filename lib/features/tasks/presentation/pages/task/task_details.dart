import 'package:flutter/material.dart';

import '../../../../../core/utils.dart';
import '../../../domain/entities/task_entity.dart';
import '../../helpers.dart';
import '../../widgets/tasks_list_view.dart';

class TaskDetails extends StatelessWidget {
  final Task task;
  final Task parent;

  const TaskDetails(this.task, {Key key, @required this.parent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loc = localeBase(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              if (task.isSubTask) {
                return Helpers.onShowSubtaskDialog(parent: parent, task: task);
              } else {
                return Helpers.onShowTaskDialog(task: task);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => Helpers.onDeleteTask(task: parent, sub: task),
          ),
          //TODO: Add share
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<String>>[
                const PopupMenuItem<String>(
                  value: 'share',
                  child: Text('Share'),
                ),
              ];
            },
          ),
        ],
      ),

      body: TasksListView(
        tasks: task.subtasks,
        parent: task,
        header: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Divider(),
                if (!task.isSubTask)
                  Row(
                    children: <Widget>[
                      const Icon(Icons.book),
                      const SizedBox(width: 10),
                      Text(
                        task?.course?.title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const Spacer(),
                      LayoutBuilder(
                        builder: (_, c) => Container(
                          height: 20,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: task?.course?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.folder),
                    const SizedBox(width: 10),
                    Text(
                      Helpers.mapTaskType(type: task.type, loc: loc),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 10),
                    Text(
                      taskDateAtTimeFormatter(context).format(task.dueDate),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.alarm),
                    const SizedBox(width: 10),
                    Text(
                      taskDateAtTimeFormatter(context).format(task.reminder),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                const Divider(),
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: loc.tasks.notes,
                    border: const OutlineInputBorder(),
                  ),
                  child: Text(
                    task.notes,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ]
                  .map(
                    (w) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 3,
                      ),
                      child: w,
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: ProgressSlider(task: task, parent: parent),
          ),
          const Divider(),
        ]
            .map((w) => Padding(
                  padding: w is Divider
                      ? const EdgeInsets.symmetric(vertical: 5)
                      : const EdgeInsets.symmetric(horizontal: 2),
                  child: w,
                ))
            .toList(),
      ),
      // body: ,
      floatingActionButton: !task.isSubTask
          ? FloatingActionButton.extended(
              onPressed: () => Helpers.onShowSubtaskDialog(parent: task),
              label: Text(loc.tasks.new_subtask),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class ProgressSlider extends StatefulWidget {
  const ProgressSlider({
    Key key,
    @required this.task,
    this.parent,
  }) : super(key: key);
  final Task parent;

  final Task task;

  @override
  _ProgressSliderState createState() => _ProgressSliderState();
}

class _ProgressSliderState extends State<ProgressSlider> {
  @override
  Widget build(BuildContext context) {
    final loc = localeBase(context);

    return InputDecorator(
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: loc.tasks.progress,
        isDense: true,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 11,
            child: Slider(
              max: 100,
              value: widget.task.progress,
              onChanged: (value) {
                setState(() {
                  widget.task.progress = value;
                });
              },
              onChangeEnd: (value) async {
                setState(() {
                  widget.task.progress = value;
                });
                if (widget.parent != null) {
                  await widget.parent.save();
                } else {
                  await widget.task.save();
                }
              },
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('${widget.task.progress.toInt()}%'),
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalizedType() {
    final value = substring(9);
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }
}
