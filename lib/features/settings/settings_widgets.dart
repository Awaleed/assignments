import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kiwi/kiwi.dart';

import '../../core/utils.dart';
import 'development_page.dart';
import 'settings_store.dart';

class SettingsExample extends StatelessWidget {
  final SettingsStore store = KiwiContainer().resolve<SettingsStore>();

  @override
  Widget build(BuildContext context) {
    final loc = localeBase(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings.settings),
      ),
      body: Observer(
        builder: (context) {
          return Form(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  DropdownButtonFormField<MaterialColor>(
                    value: store.color,
                    items: _buildItems(context),
                    onChanged: (value) {
                      store.setColor(value: value);
                    },
                  ),
                  SwitchListTile(
                    value: store.useDarkMode,
                    title: Text(loc.settings.use_dark_mode),
                    onChanged: (value) {
                      store.setDarkMode(value: value);
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: store.languageCode,
                    items: [
                      DropdownMenuItem(
                        value: '',
                        child: Text(loc.settings.auto),
                      ),
                      const DropdownMenuItem(
                        value: 'ar',
                        child: Text('عربي'),
                      ),
                      const DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                    ],
                    onChanged: (value) {
                      store.setLanguageCode(value);
                    },
                  ),
                ],
              ),
            ),
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

  List<DropdownMenuItem<MaterialColor>> _buildItems(BuildContext context) {
    final namesEn = [
      'Red',
      'Pink',
      'Purple',
      'Deep Purple',
      'Indigo',
      'Blue',
      'Light Blue',
      'Cyan',
      'Teal',
      'Green',
      'Light Green',
      'Lime',
      'Yellow',
      'Amber',
      'Orange',
      'Deep Orange',
      'Brown',
      'Blue Grey',
    ];

    final namesAr = [
      'أحمر',
      'زهري',
      'أرجواني',
      'أرجواني عميق',
      'نيلي',
      'أزرق',
      'أزرق فاتح',
      'ازرق سماوي',
      'أزرق مخضر',
      'أخضر',
      'اخضر فاتح',
      'ليموني',
      'أصفر',
      'عنبر',
      'برتقالي',
      'برتقالي عميق',
      'بنى',
      'رمادي مزرق',
    ];
    final listItems = <DropdownMenuItem<MaterialColor>>[];
    final primariesNames =
        locale(context).languageCode == 'ar' ? namesAr : namesEn;
    for (var i = 0; i < primariesNames.length; i++) {
      final item = DropdownMenuItem<MaterialColor>(
        value: Colors.primaries[i],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(primariesNames[i]),
            const SizedBox(width: 10),
            CircleAvatar(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.primaries[i],
                ),
              ),
            )
          ],
        ),
      );
      listItems.add(item);
    }
    return listItems;
  }
}
