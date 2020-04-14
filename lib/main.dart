import 'package:assignments/core/routes/router.gr.dart';
import 'package:assignments/features/settings/settings_store.dart';
import 'package:assignments/injector.dart';
import 'package:assignments/pages/home_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = kiwi.Container().resolve<SettingsStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        showPerformanceOverlay: store.showPerformanceOverlay,
        builder: ExtendedNavigator<Router>(router: Router()),
        theme: ThemeData(
          primarySwatch: store.color,
          brightness: store.useDarkMode ? Brightness.dark : Brightness.light,
        ),
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
