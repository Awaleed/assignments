import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../components/tasks_tab_view.dart';
import '../../cubits/tasks_cubit/tasks_cubit.dart';
import '../../models/task_model.dart';

class TasksScreen extends StatelessWidget {
  static const routeName = '/tasks';

  const TasksScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.tasks),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: S.current.upcoming.toUpperCase()),
              Tab(text: S.current.overdue.toUpperCase())
            ],
          ),
        ),
        body: BlocBuilder<TasksCubit, List<TaskModel>>(
          builder: (context, state) {
            return TasksTabView(tasks: state);
          },
        ),
      ),
    );
  }
}
