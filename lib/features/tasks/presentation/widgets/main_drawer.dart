import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = localeBase(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.supervised_user_circle),
            ),
            accountName: Text('XgamerXD'),
            accountEmail: Text('a.waleed0011@gmail.com'),
          ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted),
            title: Text(loc.tasks.tasks),
            onTap: () => _onChangePage(Routes.tasksPage),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: Text(loc.courses.courses),
            onTap: () => _onChangePage(Routes.coursesPage),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(loc.calendar.calendar),
            onTap: () => _onChangePage(Routes.calendarPage),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(loc.settings.settings),
            onTap: () => _onChangePage(Routes.settingsExample),
          ),
        ],
      ),
    );
  }

  void _onChangePage(String pageRoute) {
    ExtendedNavigator.root.pop();
    ExtendedNavigator.root.push(pageRoute);
  }
}
