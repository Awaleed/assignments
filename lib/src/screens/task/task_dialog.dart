import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

import '../../../generated/l10n.dart';
import '../../components/flutter_datetime_formfield.dart';
import '../../cubits/courses_cubit/courses_cubit.dart';
<<<<<<< Updated upstream
import '../../cubits/task_cubit/task_cubit.dart';
import '../../helpers/formatters.dart';
import '../../helpers/helper.dart';
=======
import '../../cubits/tasks_cubit/tasks_cubit.dart';
import '../../helpers/formatters.dart';
>>>>>>> Stashed changes
import '../../models/course_model.dart';
import '../../models/task_model.dart';
import '../../routes/config_routes.dart';
import '../course/course_dialog.dart';
import 'task_details.dart';

<<<<<<< Updated upstream
class TaskDialog extends StatelessWidget {
  static const routeName = '/tasks/new';

  const TaskDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocBuilder<TaskCubit, TaskModel>(
      builder: (context, task) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_makeTitle(context, task)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _buildName(context, task),
                  if (!task.isSubTask) _buildCoursesDropdown(context, task),
                  _buildTaskTypeDropdown(context, task),
                  const Divider(),
                  _buildDueDatePicker(context, task),
                  _buildReminderDatePicker(context, task),
                  const Divider(),
                  _buildProgress(context, task),
                  const Divider(),
                  _buildNotes(context, task),
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
            heroTag: 'TaskDialog',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.read<TaskCubit>().createTask(task);
                AppRouter.sailor.pop();
              }
            },
            label: Text(S.current.save),
            icon: const Icon(Icons.save),
          ),
        );
      },
    );
  }

  Widget _buildName(BuildContext context, TaskModel task) {
=======
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
            context.read<TasksCubit>().createTask(task);
            context.read<TasksCubit>().state.maybeWhen(
                  created: () => AppRouter.sailor.pop(),
                  orElse: () => null,
                );
          }
        },
        //  => Helpers.onSaveTask(formKey: formKey, task: task),
        label: Text(S.current.save),
        icon: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildName() {
>>>>>>> Stashed changes
    return TextFormField(
      initialValue: task.title,
      decoration: InputDecoration(
        labelText: S.current.task_name,
        border: const OutlineInputBorder(),
      ),
      onSaved: (value) => task.title = value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
<<<<<<< Updated upstream
        if (value!.isEmpty) {
          return S.current.empty_name_error_message;
        } else if (value.length < 2) {
=======
        if (value.isEmpty) {
          return S.current.empty_name_error_message;
        } else if (value.length <= 2) {
>>>>>>> Stashed changes
          return S.current.short_name_error_message;
        }
        return null;
      },
    );
  }

<<<<<<< Updated upstream
  Widget _buildCoursesDropdown(BuildContext context, TaskModel task) {
    final _course = CourseModel();
    return BlocBuilder<CoursesCubit, List<CourseModel>>(
      builder: (context, state) {
        return DropdownButtonFormField<CourseModel>(
          decoration: InputDecoration(
            icon: const Icon(Icons.book),
            hintText: S.current.please_choose_one,
          ),
          value: task.course,
          isExpanded: true,
          onChanged: (CourseModel? value) {
            if (value == null || value == _course) {
              AppRouter.sailor.navigate(CourseDialog.routeName, params: {'course_cubit': null});
            } else {
              task.course = value;
            }
          },
          onSaved: (CourseModel? value) => task.course = value,
          onTap: () => Helpers.dismissFauces(context),
          validator: (CourseModel? value) {
            if (value == null || value == _course) {
              return S.current.please_choose_one;
            } else {
              return null;
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          items: state.map(
            (course) {
              return DropdownMenuItem(
                value: course,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      course.title!,
                      overflow: TextOverflow.visible,
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
                value: _course,
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
=======
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
>>>>>>> Stashed changes
        );
      },
    );
  }

<<<<<<< Updated upstream
  Widget _buildTaskTypeDropdown(BuildContext context, TaskModel task) {
    return DropdownButtonFormField<TaskType>(
      decoration: InputDecoration(
        icon: const Icon(Icons.folder),
        hintText: S.current.please_choose_one,
      ),
      value: task.type,
      onTap: () => Helpers.dismissFauces(context),
      items: TaskType.values
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(TaskModel.getLabel(type), overflow: TextOverflow.visible),
              ))
          .toList(),
      validator: (TaskType? value) {
        if (value == null) {
          return S.current.please_choose_one;
=======
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
>>>>>>> Stashed changes
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
<<<<<<< Updated upstream
      onChanged: (TaskType? value) => task.type = value,
      onSaved: (TaskType? value) => task.type = value,
    );
  }

  Widget _buildDueDatePicker(BuildContext context, TaskModel task) {
=======
      onChanged: (TaskType value) => task.type = value,
      onSaved: (TaskType value) => task.type = value,
    );
  }

  Widget _buildDueDatePicker(BuildContext context) {
>>>>>>> Stashed changes
    return DateTimeFormField(
      decoration: InputDecoration(
        labelText: S.current.due_date,
        border: InputBorder.none,
        icon: const Icon(Icons.calendar_today),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      firstDate: DateTime.now(),
      formatter: Formatters.taskDateAtTimeFormatter,
<<<<<<< Updated upstream
      initialValue: task.dueDate ?? DateTime.now().add(1.days),
      validator: (DateTime? dateTime) {
        Helpers.dismissFauces(context);
        task.dueDate = dateTime;
        if (dateTime != null && dateTime.isBefore(DateTime.now())) {
=======
      initialValue: task.dueDate,
      validator: (DateTime dateTime) {
        task.dueDate = dateTime;
        if (dateTime.isBefore(DateTime.now())) {
>>>>>>> Stashed changes
          return S.current.overdue_error_message;
        }
        return null;
      },
<<<<<<< Updated upstream
      onSaved: (DateTime? dateTime) => task.dueDate = dateTime,
    );
  }

  Widget _buildReminderDatePicker(BuildContext context, TaskModel task) {
=======
      onSaved: (DateTime dateTime) => task.dueDate = dateTime,
    );
  }

  Widget _buildReminderDatePicker(BuildContext context) {
>>>>>>> Stashed changes
    return DateTimeFormField(
      decoration: InputDecoration(
        labelText: S.current.reminder,
        border: InputBorder.none,
        icon: const Icon(Icons.alarm),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      formatter: Formatters.taskDateAtTimeFormatter,
<<<<<<< Updated upstream
      firstDate: task.dueDate != null ? task.dueDate!.subtract(1.days) : DateTime.now(),
      initialValue:
          task.reminder ?? task.dueDate?.subtract(1.days) ?? DateTime.now().subtract(1.days),
      validator: (DateTime? dateTime) {
        Helpers.dismissFauces(context);
        task.reminder = dateTime;
        if (dateTime != null && (task.dueDate == null || dateTime.isAfter(task.dueDate!))) {
=======
      firstDate: task.dueDate != null ? task.dueDate.subtract(1.days) : DateTime.now(),
      initialValue: task.reminder ?? (task?.dueDate?.subtract(1.days)),
      validator: (DateTime dateTime) {
        task.reminder = dateTime;
        if (task.dueDate == null || dateTime.isAfter(task.dueDate)) {
>>>>>>> Stashed changes
          return S.current.reminder_date_error_message;
        }
        return null;
      },
<<<<<<< Updated upstream
      onSaved: (DateTime? dateTime) => task.reminder = dateTime,
    );
  }

  Widget _buildProgress(BuildContext context, TaskModel task) => ProgressSlider(task: task);

  Widget _buildNotes(BuildContext context, TaskModel task) {
=======
      onSaved: (DateTime dateTime) => task.reminder = dateTime,
    );
  }

  Widget _buildProgress() => ProgressSlider(task: task);

  Widget _buildNotes() {
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
  String _makeTitle(BuildContext context, TaskModel task) {
    if (task.isSubTask) {
      return task.title == null ? S.current.new_subtask : '{loc.tasks.editing}: ${task.title}';
    } else {
      return task.key == null ? S.current.new_task : '{loc.tasks.editing}: ${task.title}';
=======
  String _makeTitle() {
    if (task.isSubTask) {
      return task.title == null ? S.current.new_subtask : '{loc.tasks.editing}: ${task.title}';
    } else {
      return task.id == null ? S.current.new_task : '{loc.tasks.editing}: ${task.title}';
>>>>>>> Stashed changes
    }
  }
}
