import 'package:assignments/features/settings/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'core/routes/router.gr.dart';
import 'features/settings/flash/flash_helper.dart';
import 'features/settings/settings_store.dart';
import 'injector.dart';
import 'localedelegate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await injector();
  runApp(MyApp());
}

final SettingsStore store = kiwi.Container().resolve<SettingsStore>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlashHelper.init(context);
    return Observer(
      builder: (_) => MaterialApp(
        builder: ExtendedNavigator<Router>(router: Router()),
        showPerformanceOverlay: store.showPerformanceOverlay,
        theme: ThemeData(
          // brightness: store.useDarkMode ? Brightness.dark : Brightness.light,
          brightness: Brightness.dark,
          primarySwatch: store.color,
      
          textTheme: textTheme,
        ),
        // darkTheme: ThemeData(primarySwatch: Colors.red),
        localizationsDelegates: [
          const LocDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        locale: store.languageCode.isNotEmpty
            ? Locale('${store.languageCode}')
            : null,
        title: 'Material App',
      ),
    );
  }
}
