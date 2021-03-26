import 'package:assignments/src/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'generated/l10n.dart';
import 'init_hive.dart';
import 'init_injectable.dart';
import 'src/core/custom_bloc_observer.dart';
import 'src/data/settings_datasource.dart';
import 'src/routes/config_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  configureDependencies();
  AppRouter.createRoutes();

  Bloc.observer = CustomBlocObserver();

  await SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ]);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<SettingsModel>(settingsBoxName).listenable(),
      builder: (context, box, widget) {
        return MaterialApp(
          // title: 'Ass`',
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.primaries[box.get(currentSettingsKey).themeIndex],
            accentColor: Colors.primaries[box.get(currentSettingsKey).themeIndex],
            textTheme: _makeTextTheme(),
            primaryTextTheme: _makeTextTheme(),
          ),
          supportedLocales: S.delegate.supportedLocales,
          locale: box.get(currentSettingsKey)?.locale,
          onGenerateRoute: AppRouter.sailor.generator(),
          navigatorKey: AppRouter.sailor.navigatorKey,
          // navigatorObservers: [
          // SailorLoggingObserver(),
          // AppRouter.sailor.navigationStackObserver,
          // ],
        );
      },
    );
  }

  TextTheme _makeTextTheme() {
    // return GoogleFonts.cairoTextTheme()
    final textTheme = ThemeData.dark().textTheme;
    return TextTheme(
      headline1: GoogleFonts.cairo(textStyle: textTheme?.headline1),
      headline2: GoogleFonts.cairo(textStyle: textTheme?.headline2),
      headline3: GoogleFonts.cairo(textStyle: textTheme?.headline3),
      headline4: GoogleFonts.cairo(textStyle: textTheme?.headline4),
      headline5: GoogleFonts.cairo(textStyle: textTheme?.headline5),
      headline6: GoogleFonts.cairo(textStyle: textTheme?.headline6),
      subtitle1: GoogleFonts.cairo(textStyle: textTheme?.subtitle1),
      subtitle2: GoogleFonts.cairo(textStyle: textTheme?.subtitle2),
      bodyText1: GoogleFonts.cairo(textStyle: textTheme?.bodyText1),
      bodyText2: GoogleFonts.cairo(textStyle: textTheme?.bodyText2),
      caption: GoogleFonts.cairo(textStyle: textTheme?.caption),
      button: GoogleFonts.cairo(textStyle: textTheme?.button),
      overline: GoogleFonts.cairo(textStyle: textTheme?.overline),
      // body1: GoogleFonts.cairo(textStyle: textTheme?.body1),
      // body2: GoogleFonts.cairo(textStyle: textTheme?.body2),
      // display1: GoogleFonts.cairo(textStyle: textTheme?.display1),
      // display2: GoogleFonts.cairo(textStyle: textTheme?.display2),
      // display3: GoogleFonts.cairo(textStyle: textTheme?.display3),
      // display4: GoogleFonts.cairo(textStyle: textTheme?.display4),
      // headline: GoogleFonts.cairo(textStyle: textTheme?.headline),
      // subhead: GoogleFonts.cairo(textStyle: textTheme?.subhead),
      // subtitle: GoogleFonts.cairo(textStyle: textTheme?.subtitle),
      // title: GoogleFonts.cairo(textStyle: textTheme?.title),
    );
  }
}
