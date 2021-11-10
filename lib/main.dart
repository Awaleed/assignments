import 'package:assignments/src/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'generated/l10n.dart';
import 'init_hive.dart';
import 'init_injectable.dart';
import 'src/cubits/courses_cubit/courses_cubit.dart';
import 'src/cubits/settings_cubit/settings_cubit.dart';
import 'src/models/settings_model.dart';
import 'src/routes/config_routes.dart';
import 'src/screens/main/main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  configureDependencies();
  AppRouter.createRoutes();

  await SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ]);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SettingsCubit>()..getSettings()),
        BlocProvider(create: (context) => getIt<CoursesCubit>()..getAllCourses()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsModel>(
        builder: (context, settings) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: AppTheme.themes[settings.themeIndex].primaryColor,
              // primaryColor: AppTheme.themes[settings.themeIndex].primaryColor,
              accentColor: AppTheme.themes[settings.themeIndex].primaryColor,
              textTheme: _makeTextTheme(),
              primaryTextTheme: _makeTextTheme(),
            ),
            supportedLocales: S.delegate.supportedLocales,
            locale: settings.locale,
            onGenerateRoute: AppRouter.sailor.generator(),
            navigatorKey: AppRouter.sailor.navigatorKey,
            initialRoute: MainScreen.routeName,
          );
        },
      ),
    );
  }

  TextTheme _makeTextTheme() {
    final textTheme = ThemeData.dark().textTheme;
    return TextTheme(
      headline1: GoogleFonts.cairo(textStyle: textTheme.headline1),
      headline2: GoogleFonts.cairo(textStyle: textTheme.headline2),
      headline3: GoogleFonts.cairo(textStyle: textTheme.headline3),
      headline4: GoogleFonts.cairo(textStyle: textTheme.headline4),
      headline5: GoogleFonts.cairo(textStyle: textTheme.headline5),
      headline6: GoogleFonts.cairo(textStyle: textTheme.headline6),
      subtitle1: GoogleFonts.cairo(textStyle: textTheme.subtitle1),
      subtitle2: GoogleFonts.cairo(textStyle: textTheme.subtitle2),
      bodyText1: GoogleFonts.cairo(textStyle: textTheme.bodyText1),
      bodyText2: GoogleFonts.cairo(textStyle: textTheme.bodyText2),
      caption: GoogleFonts.cairo(textStyle: textTheme.caption),
      button: GoogleFonts.cairo(textStyle: textTheme.button),
      overline: GoogleFonts.cairo(textStyle: textTheme.overline),
    );
  }
}
