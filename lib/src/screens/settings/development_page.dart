import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../components/my_loading_overlay.dart';
import '../../data/tasks_datasource.dart';
import '../../helpers/fake_data_generator.dart';
import '../../models/course_model.dart';
import '../../models/task_model.dart';

class DevelopmentPage extends StatefulWidget {
  @override
  _DevelopmentPageState createState() => _DevelopmentPageState();
}

class _DevelopmentPageState extends State<DevelopmentPage> {
  late int cCount, tCount, stCount;
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
      delegates: const <LocalizationsDelegate>[
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
                      NumberPicker(
                        value: cCount,
                        minValue: 0,
                        maxValue: 50,
                        onChanged: (num value) => setState(() => cCount = value.toInt()),
                      ),
                      const Text('Courses'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      NumberPicker(
                        value: tCount,
                        minValue: 0,
                        maxValue: 50,
                        onChanged: (num value) => setState(() => tCount = value.toInt()),
                      ),
                      const Text('Tasks'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      NumberPicker(
                        value: stCount,
                        minValue: 0,
                        maxValue: 50,
                        onChanged: (num value) => setState(() => stCount = value.toInt()),
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
                        (index) => FakeDataGenerator.courseModel(),
                      );

                      await Hive.box<CourseModel>(coursesBoxName).addAll(courses);

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

                      await Hive.box<TaskModel>(tasksBoxName).addAll(tasks);

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
}
