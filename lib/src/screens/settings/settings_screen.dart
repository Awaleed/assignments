import 'package:assignments/generated/l10n.dart';
import 'package:assignments/src/cubits/settings_cubit/settings_cubit.dart';
import 'package:assignments/src/helpers/helper.dart';
import 'package:assignments/src/models/settings_model.dart';
import 'package:assignments/src/models/theme_model.dart';
import 'package:assignments/src/routes/config_routes.dart';
import 'package:assignments/src/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';

import 'development_page.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsScreen();

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settings),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loaded: (value) => _buildUi(context, value),
            failure: (_) => const SizedBox.shrink(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Overlay(
              initialEntries: [
                OverlayEntry(builder: (context) {
                  return DevelopmentPage();
                }),
              ],
            );
          }));
        },
        label: const Text('Dev. mode'),
        icon: const Icon(Icons.developer_mode),
      ),
    );
  }

  Widget _buildUi(BuildContext context, SettingsModel value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputDecorator(
            decoration: InputDecoration(
              isDense: true,
              labelText: S.current.theme,
              border: const OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                isDense: true,
                isExpanded: true,
                value: value.themeIndex,
                items: _buildItems(context),
                icon: CircleAvatar(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.themes[value.themeIndex].primaryColor,
                    ),
                  ),
                ),
                onChanged: (value) async {
                  await context.read<SettingsCubit>().setThemeIndex(value);
                  setState(() {});
                },
              ),
            ),
          ),
          // SwitchListTile(
          //   value: store.useDarkMode,
          //   title: Text(loc.settings.use_dark_mode),
          //   onChanged: (value) {
          //     store.setDarkMode(value: value);
          //   },
          // ),

          const Divider(),
          InputDecorator(
            decoration: InputDecoration(
              isDense: true,
              labelText: S.current.language,
              border: const OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                value: value.languageCode,
                items: [
                  DropdownMenuItem(
                    value: '',
                    child: Text(
                      S.current.auto,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text(
                      'عربي',
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'en',
                    child: Text(
                      'English',
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
                onChanged: (newValue) async {
                  if (newValue == value.languageCode) return;
                  await context.read<SettingsCubit>().setLanguageCode(newValue);
                  AppRouter.sailor.navigate(
                    SplashScreen.routeName,
                    navigationType: NavigationType.pushAndRemoveUntil,
                    removeUntilPredicate: (_) => false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> _buildItems(BuildContext context) {
    // final namesEn = [
    //   'Red',
    //   'Pink',
    //   'Purple',
    //   'Deep Purple',
    //   'Indigo',
    //   'Blue',
    //   'Light Blue',
    //   'Cyan',
    //   'Teal',
    //   'Green',
    //   'Light Green',
    //   'Lime',
    //   'Yellow',
    //   'Amber',
    //   'Orange',
    //   'Deep Orange',
    //   'Brown',
    //   'Blue Grey',
    // ];

    // final namesAr = [
    //   'أحمر',
    //   'زهري',
    //   'أرجواني',
    //   'أرجواني عميق',
    //   'نيلي',
    //   'أزرق',
    //   'أزرق فاتح',
    //   'ازرق سماوي',
    //   'أزرق مخضر',
    //   'أخضر',
    //   'اخضر فاتح',
    //   'ليموني',
    //   'أصفر',
    //   'عنبر',
    //   'برتقالي',
    //   'برتقالي عميق',
    //   'بنى',
    //   'رمادي مزرق',
    // ];
    final listItems = <DropdownMenuItem<int>>[];
    // final primariesNames = Helpers.isArabic(context) ? namesAr : namesEn;
    for (var i = 0; i < AppTheme.themes.length; i++) {
      final theme = AppTheme.themes[i];
      final item = DropdownMenuItem<int>(
        value: i,
        child: Text(
          Helpers.isArabic(context) ? theme.arabicName : theme.engleshName,
          overflow: TextOverflow.visible,
          style: Theme.of(context).textTheme.button,
        ),
      );
      listItems.add(item);
    }
    return listItems;
  }
}
