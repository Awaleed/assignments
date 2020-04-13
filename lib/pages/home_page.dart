import 'package:assignments/features/assignments/data/datasources/local_datasource.dart';
import 'package:assignments/features/assignments/presentation/bloc/assignment_bloc/assignment_bloc.dart';
import 'package:assignments/features/assignments/presentation/pages/assignment/assignments_compleated_page.dart';
import 'package:assignments/features/assignments/presentation/pages/assignment/claear_all_page.dart';
import 'package:assignments/features/preferences/bloc/bloc.dart';
import 'package:assignments/features/preferences/preferences_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/assignments/presentation/pages/assignment/assignments_page.dart';
import '../features/assignments/presentation/pages/class/classes_page.dart';
import 'custom_widgets/navigation_icon_view.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationIconView;
  final List<Widget> _children = [
    AssignmentPage(),
    AssignmentCompleatedPage(),
    ClassesPage(),
    BlocProvider(
      create: (context) => PreferencesBloc(),
      child: PreferencesPage(),
    ),
    ClearAllPage(),
  ];

  @override
  void initState() {
    super.initState();
    _navigationIconView = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.schedule),
        title: 'Schedule',
        color: Colors.deepPurple,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.check),
        title: 'Completed',
        color: Colors.teal,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.book),
        title: 'Classes',
        color: Colors.indigo,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.settings),
        title: 'Settings',
        color: Colors.pink,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.restore),
        title: 'Reset',
        color: Colors.pink,
        vsync: this,
      ),
    ];
    _navigationIconView[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationIconView)
      view.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => kiwi.Container().resolve<AssignmentsBloc>(),
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: _navigationIconView
          .map<BottomNavigationBarItem>(
              (NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _navigationIconView[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationIconView[_currentIndex].controller.forward();
        });
      },
    );
  }
}

class _TempPage extends StatelessWidget {
  const _TempPage({Key key, this.color, this.title}) : super(key: key);
  final Color color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
        backgroundColor: color,
      ),
      body: Center(
        child: Text('$title'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
