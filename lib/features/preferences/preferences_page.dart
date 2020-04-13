import 'package:assignments/features/preferences/bloc/bloc.dart';
import 'package:assignments/features/preferences/model/preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  Color primary;
  @override
  void initState() {
    super.initState();
    // BlocProvider.of(context).add(g)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          BlocBuilder<PreferencesBloc, PreferencesState>(
            builder: (context, state) => DropdownButton<Color>(
              value: Colors.primaries.firstWhere((c) =>
                  c.value == (state as PreferencesLoaded).preferences.appTheme),
              items: Colors.primaries.map((c) {
                return DropdownMenuItem(
                  child: Container(
                      child: Text(c.toString().substring(29)), color: c),
                  value: c,
                );
              }).toList(),
              onChanged: (value) {
                BlocProvider.of<PreferencesBloc>(context).add(
                    PreferencesChanged(
                        preferences: Preferences(appTheme: value.value)));
              },
            ),
          ),
          // RaisedButton(
          //   child: Text('Set theme'),
          //   onPressed: () {

          //   },
          // ),
        ],
      ),
    );
  }
}
