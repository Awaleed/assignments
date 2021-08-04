import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../components/tasks_list_view.dart';
import '../../cubits/tasks_cubit/tasks_cubit.dart';
import '../../helpers/formatters.dart';
import '../../models/task_model.dart';
import '../../routes/config_routes.dart';
import 'task_dialog.dart';

class TaskDetailsScreen extends StatelessWidget {
  static const routeName = '/tasks/:id';

  const TaskDetailsScreen({
    Key key,
    this.task,
    this.parentTask,
  }) : super(key: key);

  final TaskModel task;
  final TaskModel parentTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              AppRouter.sailor.navigate(
                TaskDialog.routeName,
                params: {'task': task},
              );
            },
          ),
          IconButton(icon: const Icon(Icons.delete), onPressed: () {} // => Helpers.onDeleteTask(task: parentTask, sub: task),
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
        parentTask: task,
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
                      TaskModel.getLabel(task.type),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        Formatters.taskDateAtTime(task.dueDate),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.alarm),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        Formatters.taskDateAtTime(task.reminder),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: S.current.notes,
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
            child: ProgressSlider(task: task, parentTask: parentTask),
          ),
          const Divider(),
        ]
            .map((w) => Padding(
                  padding: w is Divider ? const EdgeInsets.symmetric(vertical: 5) : const EdgeInsets.symmetric(horizontal: 2),
                  child: w,
                ))
            .toList(),
      ),
      // body: ,
      floatingActionButton: !task.isSubTask
          ? FloatingActionButton.extended(
              onPressed: () {}, //=> Helpers.onShowSubtaskDialog(parent: task),
              label: Text(S.current.new_subtask),
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
    this.parentTask,
  }) : super(key: key);
  final TaskModel parentTask;

  final TaskModel task;

  @override
  _ProgressSliderState createState() => _ProgressSliderState();
}

class _ProgressSliderState extends State<ProgressSlider> {
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: S.current.progress,
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
                if (widget.task.isInBox) {
                  context.read<TasksCubit>().updateTask(widget.parentTask ?? widget.task);
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
