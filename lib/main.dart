import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiwi/kiwi.dart';

import 'core/routes/app_router.gr.dart';
import 'features/settings/settings_store.dart';
import 'injector.dart';
import 'localedelegate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await injector();
  runApp(MyApp());
}

final store = KiwiContainer().resolve<SettingsStore>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        showPerformanceOverlay: store.showPerformanceOverlay,
        theme: ThemeData(
          brightness: store.useDarkMode ? Brightness.dark : Brightness.light,
          // brightness: Brightness.dark,
          primarySwatch: store.color,

          textTheme: GoogleFonts.almaraiTextTheme(),
        ),
        // darkTheme: ThemeData(primarySwatch: Colors.red),
        localizationsDelegates: [
          LocDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        locale:
            store.languageCode.isNotEmpty ? Locale(store.languageCode) : null,
        title: 'Material App',
        home: ExtendedNavigator(
          router: AppRouter(),
        ),
      ),
    );
  }
}
