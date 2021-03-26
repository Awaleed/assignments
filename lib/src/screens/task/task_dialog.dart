import 'package:assignments/generated/l10n.dart';
import 'package:assignments/src/cubits/courses_cubit/courses_cubit.dart';
import 'package:assignments/src/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:assignments/src/models/course_model.dart';
import 'package:assignments/src/routes/config_routes.dart';
import 'package:assignments/src/screens/course/course_dialog.dart';
import 'package:assignments/src/screens/task/task_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

import '../../components/flutter_datetime_formfield.dart';
import '../../helpers/formatters.dart';
import '../../models/task_model.dart';

@immutable
class TaskDialog extends StatelessWidget {
  static const routeName = '/tasks/new';

  const TaskDialog({Key key, this.task}) : super(key: key);

  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    _makeTitle();
    return Scaffold(
      appBar: AppBar(
        title: Text(_makeTitle()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _buildName(),
              if (!task.isSubTask) _buildCoursesDropdown(context),
              _buildTaskTypeDropdown(),
              const Divider(),
              _buildDueDatePicker(context),
              _buildReminderDatePicker(context),
              const Divider(),
              _buildProgress(),
              const Divider(),
              _buildNotes(),
            ].map((w) {
              return Padding(
                padding: w is Divider ? const EdgeInsets.symmetric(vertical: 5) : const EdgeInsets.symmetric(horizontal: 10),
                child: w,
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            context.read<TasksCubit>()
              ..createTask(task)
              ..listen((state) => state.maybeWhen(
                    created: () => AppRouter.sailor.pop(),
                    orElse: () => null,
                  ));
          }
        },
        //  => Helpers.onSaveTask(formKey: formKey, task: task),
        label: Text(S.current.save),
        icon: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildName() {
    return TextFormField(
      initialValue: task.title,
      decoration: InputDecoration(
        labelText: S.current.task_name,
        border: const OutlineInputBorder(),
      ),
      onSaved: (value) => task.title = value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value.isEmpty) {
          return S.current.empty_name_error_message;
        } else if (value.length <= 2) {
          return S.current.short_name_error_message;
        }
        return null;
      },
    );
  }

  Widget _buildCoursesDropdown(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        return state.when(
          // TODO use other values
          initial: () => const Placeholder(),
          loading: () => const Placeholder(),
          created: () => const Placeholder(),
          updated: () => const Placeholder(),
          deleted: () => const Placeholder(),
          failure: (_) => const Placeholder(),
          loaded: (values) => DropdownButtonFormField(
            decoration: const InputDecoration(icon: Icon(Icons.book)),
            isDense: true,
            value: task.course,
            onChanged: (value) async {
              if (value == null) {
                await AppRouter.sailor.navigate(
                  CourseDialog.routeName,
                  params: {'course': CourseModel()},
                );
                context.read<CoursesCubit>().getAllCourses();
              } else {
                task.course = value;
              }
            },
            onSaved: (value) async {
              task.course = value;
            },
            validator: (value) {
              if (value == null) {
                return S.current.empty_courses_error;
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            items: values.map(
              (course) {
                return DropdownMenuItem(
                  value: course,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        course.title,
                        textScaleFactor: 1,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(S.current.empty_courses_error),
                      const SizedBox(width: 10),
                      const FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
          ),
        );
      },
    );
  }

  Widget _buildTaskTypeDropdown() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(icon: Icon(Icons.folder)),
      isDense: true,
      value: task.type,
      items: TaskType.values
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(TaskModel.getLabel(type)),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return S.current.empty_courses_error;
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (TaskType value) => task.type = value,
      onSaved: (TaskType value) => task.type = value,
    );
  }

  Widget _buildDueDatePicker(BuildContext context) {
    return DateTimeFormField(
      decoration: InputDecoration(
        labelText: S.current.due_date,
        border: InputBorder.none,
        icon: const Icon(Icons.calendar_today),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      firstDate: DateTime.now(),
      formatter: Formatters.taskDateAtTimeFormatter,
      initialValue: task.dueDate,
      validator: (DateTime dateTime) {
        task.dueDate = dateTime;
        if (dateTime.isBefore(DateTime.now())) {
          return S.current.overdue_error_message;
        }
        return null;
      },
      onSaved: (DateTime dateTime) => task.dueDate = dateTime,
    );
  }

  Widget _buildReminderDatePicker(BuildContext context) {
    return DateTimeFormField(
      decoration: InputDecoration(
        labelText: S.current.reminder,
        border: InputBorder.none,
        icon: const Icon(Icons.alarm),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      formatter: Formatters.taskDateAtTimeFormatter,
      firstDate: task.dueDate != null ? task.dueDate.subtract(1.days) : DateTime.now(),
      initialValue: task.reminder ?? (task?.dueDate?.subtract(1.days)),
      validator: (DateTime dateTime) {
        task.reminder = dateTime;
        if (task.dueDate == null || dateTime.isAfter(task.dueDate)) {
          return S.current.reminder_date_error_message;
        }
        return null;
      },
      onSaved: (DateTime dateTime) => task.reminder = dateTime,
    );
  }

  Widget _buildProgress() => ProgressSlider(task: task);

  Widget _buildNotes() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: S.current.notes,
        border: const OutlineInputBorder(),
      ),
      initialValue: task.notes,
      onSaved: (value) => task.notes = value,
      minLines: 1,
      maxLines: 10,
    );
  }

  String _makeTitle() {
    if (task.isSubTask) {
      return task.title == null ? S.current.new_subtask : '{loc.tasks.editing}: ${task.title}';
    } else {
      return task.id == null ? S.current.new_task : '{loc.tasks.editing}: ${task.title}';
    }
  }
}
