import 'package:flutter/material.dart';

class PlaygroundScreen extends StatelessWidget {
  static const routeName = '/playground';
  const PlaygroundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('playground'),
      ),
    );
  }
}
