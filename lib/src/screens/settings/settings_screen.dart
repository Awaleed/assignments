import 'package:assignments/src/patched_components/sailor/sailor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../cubits/settings_cubit/settings_cubit.dart';
import '../../helpers/helper.dart';
import '../../models/settings_model.dart';
import '../../models/theme_model.dart';
import '../../routes/config_routes.dart';
import '../main/main.dart';
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
      appBar: AppBar(title: Text(S.current.settings)),
      body: BlocBuilder<SettingsCubit, SettingsModel>(
        builder: (context, settings) {
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
                      value: settings.themeIndex,
                      items: _buildItems(context),
                      icon: CircleAvatar(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppTheme.themes[settings.themeIndex].primaryColor,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value == null) return;
                        context.read<SettingsCubit>().setThemeIndex(value);
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
                      value: settings.languageCode,
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
                        if (newValue == null || newValue == settings.languageCode) return;
                        await context.read<SettingsCubit>().setLanguageCode(newValue);
                        AppRouter.sailor.navigate(
                          MainScreen.routeName,
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
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'SettingsScreen$hashCode',
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

  List<DropdownMenuItem<int>> _buildItems(BuildContext context) {
    final listItems = <DropdownMenuItem<int>>[];
    for (var i = 0; i < AppTheme.themes.length; i++) {
      final theme = AppTheme.themes[i];
      final item = DropdownMenuItem<int>(
        value: i,
        child: Text(
          Helpers.isArabic ? theme.arabicName : theme.engleshName,
          overflow: TextOverflow.visible,
          style: Theme.of(context).textTheme.button,
        ),
      );
      listItems.add(item);
    }
    return listItems;
  }
}
