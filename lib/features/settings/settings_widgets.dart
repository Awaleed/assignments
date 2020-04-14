import 'package:assignments/features/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SettingsExample extends StatelessWidget {
  const SettingsExample(this.store);

  final SettingsStore store;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Observer(
        builder: (context) => Column(
          children: <Widget>[
            SwitchListTile(
              value: store.useDarkMode,
              title: const Text('Use dark mode'),
              onChanged: (value) {
                store.setDarkMode(value: value);
              },
            ),
            SwitchListTile(
              value: store.showPerformanceOverlay,
              title: const Text('Show performance overlay'),
              onChanged: (value) {
                store.setShowPerformanceOverlay(value: value);
              },
            ),
            DropdownButton<Color>(
              value: store.color,
              items: Colors.primaries.map((c) {
                return DropdownMenuItem(
                  child: Container(
                      child: Text(c.toString().substring(29)), color: c),
                  value: c,
                );
              }).toList(),
              onChanged: (value) {
                store.setColor(value: value);
              },
            )
          ],
        ),
      ));
}
