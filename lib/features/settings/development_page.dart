import 'dart:async';

import 'package:assignments/features/settings/flash/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:numberpicker/numberpicker.dart';

import '../tasks/presentation/store/tasks.dart';
import 'flash/flash_helper.dart';
import 'settings_store.dart';

class DevelopmentPage extends StatefulWidget {
  @override
  _DevelopmentPageState createState() => _DevelopmentPageState();
}

class _DevelopmentPageState extends State<DevelopmentPage> {
  SettingsStore store = kiwi.Container().resolve<SettingsStore>();
  TasksStore tasksStore = kiwi.Container().resolve<TasksStore>();

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
      locale: Locale('en'),
      child: Scaffold(
        appBar: AppBar(title: Text('Be careful...')),
        body: ListView(
          children: <Widget>[
            SwitchListTile(
              value: store.showPerformanceOverlay,
              title: Text('Show performance overlay'),
              onChanged: (value) {
                store.setShowPerformanceOverlay(value: value);
              },
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    NumberPicker.integer(
                      highlightSelectedValue: true,
                      itemExtent: 25,
                      initialValue: cCount,
                      minValue: 0,
                      maxValue: 50,
                      onChanged: (value) => setState(() => cCount = value),
                    ),
                    Text('Courses'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    NumberPicker.integer(
                      highlightSelectedValue: true,
                      itemExtent: 25,
                      initialValue: tCount,
                      minValue: 0,
                      maxValue: 50,
                      onChanged: (value) => setState(() => tCount = value),
                    ),
                    Text('Tasks'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    NumberPicker.integer(
                      highlightSelectedValue: true,
                      itemExtent: 25,
                      initialValue: stCount,
                      minValue: 0,
                      maxValue: 50,
                      onChanged: (value) => setState(() => stCount = value),
                    ),
                    Text('Subtasks'),
                  ],
                ),
              ],
            ),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    var completer = Completer();
                    tasksStore
                        .seedDatabase(cCount, tCount, stCount)
                        .then((_) => completer.complete());

                    FlashHelper.blockDialog(
                      context,
                      dismissCompleter: completer,
                    );
                  },
                  color: Colors.amber,
                  child: const Text('SEED DATA'),
                ),
                RaisedButton(
                  onPressed: () {
                    var completer = Completer();
                    tasksStore.resetData().then((_) => completer.complete());
                    FlashHelper.blockDialog(
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Overlay(
                initialEntries: [
                  OverlayEntry(builder: (context) {
                    return FlashPage();
                  }),
                ],
              );
            }));
          },
          label: Text('Show Flashes'),
          icon: Icon(Icons.bubble_chart),
        ),
      ),
    );
  }
}
