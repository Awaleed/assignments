import 'package:assignments/core/routes/router.gr.dart';
import 'package:assignments/injector.dart';
import 'package:assignments/pages/home_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

void main() {
  injecte();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: ExtendedNavigator<Router>(router: Router()),
      title: 'Material App',
      home: HomePage(),
    );
  }
}
