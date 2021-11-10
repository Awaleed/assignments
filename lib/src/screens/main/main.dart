import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../components/indexed_transition_switcher.dart';
import '../../helpers/helper.dart';
import '../../routes/config_routes.dart';
import '../calendar/calendar.dart';
import '../course/courses_screen.dart';
import '../settings/settings_screen.dart';
import '../task/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _page = 0;
  List<GlobalKey<NavigatorState>> navKeys = List.generate(4, (_) => GlobalKey<NavigatorState>());

  late List<_NavItem> navItems;

  late List<Widget> pages;
  @override
  void initState() {
    super.initState();
    navItems = [
      _NavItem(Icons.format_list_bulleted, S.current.tasks),
      _NavItem(Icons.calendar_today, S.current.calendar),
      _NavItem(Icons.subject, S.current.courses),
      _NavItem(Icons.settings, S.current.settings),
    ];

    pages = [
      Navigator(
        key: navKeys[0],
        onGenerateRoute: AppRouter.sailor.generator(),
        initialRoute: TasksScreen.routeName,
      ),
      Navigator(
        key: navKeys[2],
        onGenerateRoute: AppRouter.sailor.generator(),
        initialRoute: CalendarScreen.routeName,
      ),
      Navigator(
        key: navKeys[1],
        onGenerateRoute: AppRouter.sailor.generator(),
        initialRoute: CoursesScreen.routeName,
      ),
      Navigator(
        key: navKeys[3],
        onGenerateRoute: AppRouter.sailor.generator(),
        initialRoute: SettingsScreen.routeName,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navKeys[_page].currentState!.canPop()) {
          navKeys[_page].currentState!.pop();
          return false;
        }
        return Helpers.onWillPop(context);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).accentColor,
            currentIndex: _page,
            onTap: (value) => setState(() => _page = value),
            items: [
              for (var i = 0; i < navItems.length; i++)
                BottomNavigationBarItem(
                  icon: Icon(
                    navItems[i].icon,
                    color: _page == i ? Theme.of(context).accentColor : null,
                  ),
                  label: navItems[i].label,
                ),
            ]),
        body: IndexedTransitionSwitcher(
          duration: const Duration(milliseconds: 800),
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) => SharedAxisTransition(
            animation: primaryAnimation,
            fillColor: Colors.transparent,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          ),
          index: _page,
          children: pages,
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem(this.icon, this.label);
}
