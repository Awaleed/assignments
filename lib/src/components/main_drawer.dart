<<<<<<< Updated upstream
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
=======
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../data/user_datasource.dart';
>>>>>>> Stashed changes
import '../routes/config_routes.dart';
import '../screens/calendar/calendar.dart';
import '../screens/course/courses_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/task/tasks_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // UserAccountsDrawerHeader(
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: CachedNetworkImageProvider(kUser.image),
          //   ),
          //   accountName: Text(kUser.name),
          //   accountEmail: Text(kUser.email),
          // ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted),
            title: Text(S.current.tasks),
            onTap: () => AppRouter.sailor.navigate(TasksScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: Text(S.current.courses),
            onTap: () => AppRouter.sailor.navigate(CoursesScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(S.current.calendar),
            onTap: () => AppRouter.sailor.navigate(CalendarScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(S.current.settings),
            onTap: () => AppRouter.sailor.navigate(SettingsScreen.routeName),
          ),
        ],
      ),
    );
  }
}
