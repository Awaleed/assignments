import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/custom_types/custom_types.dart';
import '../../../../../core/utils.dart';
import '../../../../../generated/locale_base.dart';
import '../../../domain/entities/course_entity.dart';
import '../../../domain/entities/task_entity.dart';
import '../../helpers.dart';
import '../../widgets/flutter_datetime_formfield.dart';

@immutable
class TaskDialog extends StatefulWidget {
  final Task task;
  final bool fixedCourse;
  final bool fixedDate;
  const TaskDialog(
    this.task, {
    Key key,
    this.fixedCourse = false,
    this.fixedDate = false,
  }) : super(key: key);

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  GlobalKey<FormState> formKey;

  String title;
  LocaleBase loc;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    loc = localeBase(context);

    _makeTitle();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _buildName(),
              if (!widget.task.isSubTask) _buildCoursesDropdown(),
              _buildTaskTypeDropdown(),
              const Divider(),
              _buildDueDatePicker(),
              _buildReminderDatePicker(),
              const Divider(),
              _buildProgress(),
              const Divider(),
              _buildNotes(),
            ].map((w) {
              return Padding(
                padding: w is Divider
                    ? const EdgeInsets.symmetric(vertical: 5)
                    : const EdgeInsets.symmetric(horizontal: 10),
                child: w,
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Helpers.onSaveTask(formKey: formKey, task: widget.task),
        label: Text('${loc.tasks.save}'),
        icon: Icon(Icons.save),
      ),
    );
  }

  Widget _buildName() {
    return TextFormField(
      initialValue: widget.task.title,
      decoration: InputDecoration(
        labelText: '${loc.tasks.task_name}',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => widget.task.title = value,
      validator: (value) {
        if (value.isEmpty) {
          return '${loc.tasks.empty_name_error_message}';
        } else if (value.length <= 2) {
          return '${loc.tasks.short_name_error_message}';
        }
        return null;
      },
    );
  }

  Widget _buildCoursesDropdown() {
    return IgnorePointer(
      ignoring: widget.fixedCourse,
      child: Observer(
        builder: (_) => DropdownButtonFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.book),
            enabled: !widget.fixedCourse,
          ),
          isDense: true,
          value: widget.task.course,
          onChanged: (Course value) async {
            if (value == null) {
              await Helpers.onShowCourseDialog(task: widget.task);
            } else {
              setState(() {
                widget.task.course = value;
              });
            }
          },
          // autovalidate: true,
          validator: (value) {
            if (value == null) {
              return '${loc.tasks.empty_courses_error}';
            } else {
              return null;
            }
          },
          items: Helpers.store.courses.map(
            (course) {
              return DropdownMenuItem(
                value: course,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${course.title}',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: widget.fixedCourse
                            ? Theme.of(context).disabledColor
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: course.color,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList()
            ..add(
              DropdownMenuItem(
                value: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${loc.tasks.empty_courses_error}'),
                    const SizedBox(width: 10),
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }

  Widget _buildTaskTypeDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(icon: Icon(Icons.folder)),
      isDense: true,
      value: widget.task.type,
      items: TaskType.values
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text('${Helpers.mapTaskType(type: type, loc: loc)}'),
              ))
          .toList(),
      onChanged: (TaskType value) {
        setState(() {
          widget.task.type = value;
        });
      },
    );
  }

  Widget _buildDueDatePicker() {
    return DateTimeFormField(
      decoration: InputDecoration(
        labelText: '${loc.tasks.due_date}',
        border: InputBorder.none,
        icon: Icon(Icons.calendar_today),
      ),
      autovalidate: true,
      onlyTime: widget.fixedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      formatter: taskDateAtTimeFormatter(context),
      initialValue: widget.task.dueDate,
      validator: (DateTime dateTime) {
        widget.task.dueDate = dateTime;
        if (dateTime.isBefore(DateTime.now())) {
          return '${loc.tasks.overdue_error_message}';
        }
        return null;
      },
      onSaved: (DateTime dateTime) => widget.task.dueDate = dateTime,
    );
  }

  Widget _buildReminderDatePicker() {
    return DateTimeFormField(
      decoration: InputDecoration(
        labelText: '${loc.tasks.reminder}',
        border: InputBorder.none,
        icon: Icon(Icons.alarm),
      ),
      autovalidate: true,
      formatter: taskDateAtTimeFormatter(context),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      initialValue: widget.task.reminder,
      validator: (DateTime dateTime) {
        widget.task.reminder = dateTime;
        if (dateTime.isAfter(widget.task.dueDate)) {
          return '${loc.tasks.reminder_date_error_message}';
        }
        return null;
      },
      onSaved: (DateTime dateTime) => widget.task.reminder = dateTime,
    );
  }

  Widget _buildProgress() {
    return InputDecorator(
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: '${loc.tasks.progress}',
        isDense: true,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 11,
            child: Slider(
              min: 0,
              max: 100,
              value: widget.task.progress,
              onChanged: (value) {
                setState(() {
                  widget.task.progress = value;
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('${widget.task.progress.toInt()}%'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotes() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '${loc.tasks.notes}',
        hasFloatingPlaceholder: true,
        border: OutlineInputBorder(),
      ),
      initialValue: widget.task.notes,
      onChanged: (value) => widget.task.notes = value,
      minLines: 1,
      maxLines: 10,
    );
  }

  void _makeTitle() {
    if (widget.task.isSubTask) {
      title = widget.task.title == null
          ? '${loc.tasks.new_subtask}'
          : '${loc.tasks.editing}: ${widget.task.title}';
    } else {
      title = widget.task.id == null
          ? '${loc.tasks.new_task}'
          : '${loc.tasks.editing}: ${widget.task.title}';
    }
  }
}
