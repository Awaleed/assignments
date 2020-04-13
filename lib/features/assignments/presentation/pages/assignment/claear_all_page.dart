import 'package:flutter/material.dart';

import '../../../data/datasources/local_datasource.dart';

class ClearAllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compleated'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Clear All'),
          onPressed: () => _clearAll(context),
        ),
      ),
    );
  }

  void _clearAll(BuildContext context) async {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Clearing Data...')));
    await LocalDataSourceImpl().clearAll();
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Data is gone...')));
  }
}
