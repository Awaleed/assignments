import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiwi/kiwi.dart';
import 'package:numberpicker/numberpicker.dart';

import '../tasks/presentation/store/tasks.dart';
import 'settings_store.dart';

class DevelopmentPage extends StatefulWidget {
  @override
  _DevelopmentPageState createState() => _DevelopmentPageState();
}

class _DevelopmentPageState extends State<DevelopmentPage> {
  SettingsStore store = KiwiContainer().resolve<SettingsStore>();

  TasksStore tasksStore = KiwiContainer().resolve<TasksStore>();

  int cCount, tCount, stCount;

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
      child: Scaffold(
        appBar: AppBar(title: const Text('Be careful...')),
        body: ListView(
          children: <Widget>[
            SwitchListTile(
              value: store.showPerformanceOverlay,
              title: const Text('Show performance overlay'),
              onChanged: (value) {
                store.setShowPerformanceOverlay(value: value);
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    NumberPicker.integer(
                      itemExtent: 25,
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
                      itemExtent: 25,
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
                      itemExtent: 25,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    final completer = Completer();
                    tasksStore
                        .seedDatabase(cCount, tCount, stCount)
                        .then((_) => completer.complete());

                    _showLoading(
                      context,
                      dismissCompleter: completer,
                    );
                  },
                  color: Colors.amber,
                  child: const Text('SEED DATA'),
                ),
                RaisedButton(
                  onPressed: () {
                    final completer = Completer();
                    tasksStore.resetData().then((_) => completer.complete());
                    _showLoading(
                      context,
                      dismissCompleter: completer,
                    );
                  },
                  color: Colors.red,
                  child: const Text('DELETE ALL'),
                ),
              ],
            ),
          ],
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
