import 'package:flutter/material.dart';

import '../../../../core/routes/router.gr.dart';
import '../../../../core/utils.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = localeBase(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.supervised_user_circle),
            ),
            accountName: const Text('XgamerXD'),
            accountEmail: const Text('a.waleed0011@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.format_list_bulleted),
            title: Text('${loc.tasks.tasks}'),
            onTap: () => _onChangePage(Routes.tasksPage),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('${loc.courses.courses}'),
            onTap: () => _onChangePage(Routes.coursesPage),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('${loc.calendar.calendar}'),
            onTap: () => _onChangePage(Routes.calendarPage),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('${loc.settings.settings}'),
            onTap: () => _onChangePage(Routes.settingsPage),
          ),
        ],
      ),
    );
  }

  void _onChangePage(String pageRoute) {
    Router.navigator.pop();
    Router.navigator.pushNamed(pageRoute);
  }
}
