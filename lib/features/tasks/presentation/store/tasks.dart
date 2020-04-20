import 'dart:async';

import 'package:assignments/core/custom_types/custom_types.dart';
import 'package:faker/faker.dart';
import 'package:hive/hive.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:mobx/mobx.dart';

import '../../domain/entities/course_entity.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../../domain/usecases/task_usecase.dart';

part 'tasks.g.dart';

enum VisibilityFilter { upcoming, overdue }

class TasksStore extends _TasksStore with _$TasksStore {}

abstract class _TasksStore with Store {
  static final TaskUseCases _useCases = TaskUseCases(
    kiwi.Container().resolve<TasksRepository>(),
  );

  @observable
  ObservableList<Course> courses = ObservableList<Course>();
  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @computed
  List<Task> get overdueTasks {
    final filteredTasks = <Task>[];
    for (final task in tasks) {
      if (task.dueDate.isBefore(DateTime.now())) {
        filteredTasks.add(task);
      }
    }

    return filteredTasks;
  }

  @computed
  List<Task> get pendingTasks {
    final filteredTasks = <Task>[];
    for (final task in tasks) {
      if (task.dueDate.isAfter(DateTime.now())) {
        filteredTasks.add(task);
      }
    }

    return filteredTasks;
  }

  _TasksStore() {
    getData();
  }

  Future<void> getData() async {
    courses = ObservableList.of(_useCases.getCourses());
    tasks = ObservableList.of(_useCases.getTasks());
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  @action
  Future<void> addCourse(Course course) async {
    await _useCases.addCourse(course);
    getData();
  }

  @action
  Future<void> deleteCourse(Course course) async {
    await _useCases.deleteCourse(course);
    getData();
  }

  @action
  Future<void> updateCourse(Course course) async {
    await _useCases.updateCourse(course);
    getData();
  }

  @action
  Future<void> addTask(Task task) async {
    await _useCases.addTask(task);
    getData();
  }

  @action
  Future<void> updateTask(Task task) async {
    await _useCases.updateTask(task);
    getData();
  }

  @action
  Future<void> deleteTask(Task task) async {
    await _useCases.deleteTask(task);
    getData();
  }

  Future<void> resetData() async {
    final Box<Task> tasksBox = Hive.box('tasks');
    final Box<Course> coursesBox = Hive.box('courses');
    await tasksBox.clear();
    await coursesBox.clear();
    getData();
  }

  Future<void> seedDatabase(int cCount, int tCount, int stCount) async {
    var courses = List.generate(cCount, (index) {
      return Course(
        title: faker.company.name(),
        colorIndex: faker.randomGenerator.integer(18),
      );
    });

    for (final course in courses) {
      await addCourse(course);
    }

    for (final course in courses) {
      final tasks = List.generate(
        tCount,
        (index) => Task(
          title: faker.food.dish(),
          course: course,
          dueDate: faker.date.dateTime(minYear: 2019, maxYear: 2021),
          reminder: faker.date.dateTime(minYear: 2017, maxYear: 2018),
          progress: faker.randomGenerator.integer(100).toDouble(),
          type: TaskType.values[faker.randomGenerator.integer(
            TaskType.values.length,
          )],
          notes: faker.lorem.sentence(),
          subtasks: List.generate(
            stCount,
            (index) => Task(
              isSubTask: true,
              title: faker.food.dish(),
              dueDate: faker.date.dateTime(minYear: 2019, maxYear: 2021),
              reminder: faker.date.dateTime(minYear: 2017, maxYear: 2018),
              progress: faker.randomGenerator.integer(100).toDouble(),
              type: TaskType.values[faker.randomGenerator.integer(
                TaskType.values.length,
              )],
              notes: faker.lorem.sentence(),
            ),
          ),
        ),
      );
      for (final task in tasks) {
        await addTask(task);
      }
    }
  }
}
