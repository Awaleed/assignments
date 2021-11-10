import 'dart:math';

import 'package:faker/faker.dart';
import 'package:supercharged/supercharged.dart';

import '../models/course_model.dart';
import '../models/task_model.dart';

abstract class FakeDataGenerator {
  // static UserModel get userModel => UserModel(
  //       // id: random.integer(1000),
  //       name: faker.person.name(),
  //       email: faker.internet.email(),
  //       // phone: '${random.integer(4294967296)}',
  //       image: faker.image.image(),
  //     );

  static TaskModel taskModel(CourseModel course, int stCount) => subTaskModel(course)
    ..subtasks = List.generate(
      random.integer(stCount),
      (_) => subTaskModel(course),
    );

  static TaskModel subTaskModel(CourseModel course) => TaskModel(
        type: TaskType.values.random,
        title: faker.job.title(),
        reminder: DateTime.now().randomize,
        dueDate: DateTime.now().randomize,
        notes: faker.lorem.sentence(),
        progress: random.decimal(scale: 100),
        course: course,
      );

  static CourseModel courseModel() => CourseModel(
        title: faker.job.title(),
        colorValue: random.integer(0xFFFFFFFF, min: 0xFF000000),
        tasks: [],
      );
}

extension on List {
  dynamic get random => this[Random().nextInt(length)];
}

extension on DateTime {
  DateTime get randomize {
    if (faker.randomGenerator.boolean()) {
      return add(faker.randomGenerator.integer(1000).hours);
    } else {
      return subtract(faker.randomGenerator.integer(1000).hours);
    }
  }
}
