import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

import '../../../core/custom_types/custom_types.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../generated/locale_base.dart';
import '../domain/entities/course_entity.dart';
import '../domain/entities/task_entity.dart';
import 'store/tasks.dart';

abstract class Helpers {
  static TasksStore store = KiwiContainer().resolve<TasksStore>();

  static Course _course() => Course(colorIndex: Random().nextInt(18));
  static Task _task({
    Course course,
    DateTime dueDate,
  }) {
    Course mCourse;
    if (course != null) {
      mCourse = course;
    } else {
      mCourse = store.courses.isNotEmpty ? store.courses.first : null;
    }
    DateTime mDueDate;
    if (dueDate != null) {
      mDueDate = DateTime(
        dueDate.year,
        dueDate.month,
        dueDate.day,
        TimeOfDay.now().hour + 1,
        TimeOfDay.now().minute,
      );
    } else {
      mDueDate = DateTime.now().add(const Duration(days: 1));
    }
    DateTime mReminder = DateTime(
      mDueDate.year,
      mDueDate.month,
      mDueDate.day - 1,
      mDueDate.hour - 1,
      mDueDate.minute - 30,
    );
    if (mReminder.isBefore(DateTime.now())) {
      mReminder = DateTime.now().add(
        const Duration(minutes: 30),
      );
    }

    return Task(
      type: TaskType.homework,
      course: mCourse,
      dueDate: mDueDate,
      reminder: mReminder,
      progress: 0,
      notes: '',
      subtasks: [],
    );
  }

  static Task _subtask() => Task(
        isSubTask: true,
        type: TaskType.homework,
        dueDate: DateTime.now().add(const Duration(days: 1)),
        reminder: DateTime.now().add(
          const Duration(
            days: 1,
            hours: -1,
            minutes: -30,
          ),
        ),
        progress: 0,
        notes: '',
      );

  static Future<void> onShowTaskDialog({
    Task task,
    Course course,
    DateTime dueDate,
    bool fixedCourse = false,
    bool fixedDate = false,
  }) async {
    final mTask = await ExtendedNavigator.root.push<Task>(
      Routes.taskDialog,
      arguments: TaskDialogArguments(
        task: task ?? _task(course: course, dueDate: dueDate),
        fixedCourse: fixedCourse,
        fixedDate: fixedDate,
      ),
    );
    if (mTask != null) {
      if (!mTask.isInBox) {
        await store.addTask(mTask);
      } else {
        await store.updateTask(mTask);
        Helpers.onShowTaskDetails(task: task);
      }
    }
  }

  static Future<void> onShowSubtaskDialog({Task parent, Task task}) async {
    final Task mTask = await ExtendedNavigator.root.push(
      Routes.taskDialog,
      arguments: TaskDialogArguments(
        task: task ?? _subtask(),
      ),
    );
    if (mTask != null) {
      if (task == null) {
        parent.subtasks.add(mTask);
      }
      await store.updateTask(parent);
    }
  }

  static Future<void> onShowCourseDialog({Course course, Task task}) async {
    final Course mCourse = await ExtendedNavigator.root.push<Course>(
      Routes.courseDialog,
      arguments: CourseDialogArguments(course: course ?? _course()),
    );
    if (mCourse != null) {
      if (!mCourse.isInBox) {
        await store.addCourse(mCourse);
        if (task != null) {
          task.course = mCourse;
          ExtendedNavigator.root.pop();
          await Helpers.onShowTaskDialog(task: task, course: mCourse);
        }
      } else {
        await store.updateCourse(mCourse);
        ExtendedNavigator.root.pop();
        Helpers.onShowCourseDetails(mCourse);
      }
    }
  }

  static void onShowCourseDetails(Course course) {
    ExtendedNavigator.root.push(
      Routes.courseDetails,
      arguments: CourseDetailsArguments(course: course),
    );
  }

  static Future<bool> onWillPop(BuildContext context) async {
    bool pop = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Discard changes?'),
          content: const Text(
            "The data you have entered hasn't been saved yet, Are you sure?",
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                ExtendedNavigator.root.pop();
                pop = true;
              },
              child: const Text('DISCARD'),
            ),
            FlatButton(
              onPressed: () => ExtendedNavigator.root.pop(),
              child: const Text('KEEP EDITING'),
            )
          ],
        );
      },
    );
    return pop;
  }

  static void onSaveCourse({Course course, GlobalKey<FormState> formKey}) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      ExtendedNavigator.root.pop(course);
    }
  }

  static void onSaveTask({GlobalKey<FormState> formKey, Task task}) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      ExtendedNavigator.root.pop(task);
    }
  }

  static int mapColor(Color value) =>
      Colors.primaries.indexOf(value as MaterialColor);

  static void onDeleteCourse(Course course) {
    store.deleteCourse(course);
    ExtendedNavigator.root.pop();
  }

  static Future<void> onDeleteTask({Task task, Task sub}) async {
    if (sub.isSubTask) {
      task.subtasks.removeWhere((st) => st == sub);
      await store.updateTask(task);
    } else {
      await store.deleteTask(sub);
    }
    ExtendedNavigator.root.pop();
  }

  static void onShowTaskDetails({Task parent, Task task}) {
    ExtendedNavigator.root.push(
      Routes.taskDetails,
      arguments: TaskDetailsArguments(parent: parent, task: task),
    );
  }

  static String mapTaskType({TaskType type, LocaleBase loc}) {
    switch (type) {
      case TaskType.homework:
        return loc.tasks.homework;
        break;
      case TaskType.project:
        return loc.tasks.project;
        break;
      case TaskType.quiz:
        return loc.tasks.quiz;
        break;
      case TaskType.test:
        return loc.tasks.test;
        break;
      default:
        return 'Type not found...';
    }
  }
}
