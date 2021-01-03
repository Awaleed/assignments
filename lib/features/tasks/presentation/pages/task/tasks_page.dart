import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/utils.dart';
import '../../helpers.dart';
import '../../widgets/main_drawer.dart';
import '../../widgets/tasks_tab_view.dart';

class TasksPage extends StatefulWidget {
  const TasksPage();

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = localeBase(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.tasks.tasks),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: loc.tasks.upcoming.toUpperCase()),
            Tab(text: loc.tasks.overdue.toUpperCase())
          ],
        ),
      ),
      drawer: MainDrawer(),
      body: Observer(
        builder: (_) => TasksTabView(
          overdue: Helpers.store.overdueTasks,
          upcoming: Helpers.store.pendingTasks,
          tabController: _tabController,
          onAddTask: () => Helpers.onShowTaskDialog(),
        ),
      ),
    );
  }
}
