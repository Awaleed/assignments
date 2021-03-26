import 'dart:async';

import 'package:assignments/src/components/my_loading_overlay.dart';
import 'package:assignments/src/data/tasks_datasource.dart';
import 'package:assignments/src/helpers/fake_data_generator.dart';
import 'package:assignments/src/models/course_model.dart';
import 'package:assignments/src/models/task_model.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:numberpicker/numberpicker.dart';

class DevelopmentPage extends StatefulWidget {
  @override
  _DevelopmentPageState createState() => _DevelopmentPageState();
}

class _DevelopmentPageState extends State<DevelopmentPage> {
  int cCount, tCount, stCount;
  bool isLoading = false;

  @override
  void initState() {
    cCount = 0;
    tCount = 0;
    stCount = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Localizations(
      delegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: const Locale('en'),
      child: MyLoadingOverLay(
        isLoading: isLoading,
        showSpinner: true,
        child: Scaffold(
          appBar: AppBar(title: const Text('Be careful...')),
          body: ListView(
            children: <Widget>[
              SwitchListTile(
                value: true,
                title: const Text('Show performance overlay'),
                onChanged: (value) {},
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      NumberPicker.integer(
                        initialValue: cCount,
                        minValue: 0,
                        maxValue: 50,
                        onChanged: (num value) =>
                            setState(() => cCount = value.toInt()),
                      ),
                      const Text('Courses'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      NumberPicker.integer(
                        initialValue: tCount,
                        minValue: 0,
                        maxValue: 50,
                        onChanged: (num value) =>
                            setState(() => tCount = value.toInt()),
                      ),
                      const Text('Tasks'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      NumberPicker.integer(
                        initialValue: stCount,
                        minValue: 0,
                        maxValue: 50,
                        onChanged: (num value) =>
                            setState(() => stCount = value.toInt()),
                      ),
                      const Text('Subtasks'),
                    ],
                  ),
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final courses = List.generate(
                        cCount,
                        (index) => FakeDataGenerator.courseModel(index),
                      );

                      Iterable ids = await Hive.box<CourseModel>(coursesBoxName)
                          .addAll(courses);
                      for (var i = 0; i < courses.length; i++) {
                        courses[i].id = ids.elementAt(0);
                        courses[i].save();
                      }

                      final tasks = <TaskModel>[];
                      for (final course in courses) {
                        final _tasks = List.generate(
                          tCount,
                          (index) => FakeDataGenerator.taskModel(course, stCount),
                        );
                        tasks
                          ..addAll(_tasks)
                          ..shuffle();
                      }

                      ids =
                          await Hive.box<TaskModel>(tasksBoxName).addAll(tasks);

                      for (var i = 0; i < tasks.length; i++) {
                        tasks[i].id = ids.elementAt(0);
                        tasks[i].save();
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      minimumSize: MaterialStateProperty.all(
                        const Size.fromRadius(30),
                      ),
                    ),
                    child: const Text('SEED DATA'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Hive.box<TaskModel>(tasksBoxName).clear();
                      await Hive.box<CourseModel>(coursesBoxName).clear();
                      setState(() {
                        isLoading = false;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      minimumSize: MaterialStateProperty.all(
                        const Size.fromRadius(30),
                      ),
                    ),
                    child: const Text('DELETE ALL'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLoading(BuildContext context, {Completer dismissCompleter}) {
    showFlash(
      context: context,
      persistent: false,
      onWillPop: () => Future.value(false),
      builder: (context, FlashController controller) {
        dismissCompleter.future.then((value) => controller.dismiss(value));
        return Flash.dialog(
          controller: controller,
          barrierDismissible: false,
          backgroundColor: Colors.black87,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        );
      },
    );
  }
}
