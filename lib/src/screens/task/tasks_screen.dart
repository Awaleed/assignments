import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
<<<<<<< Updated upstream
import '../../components/tasks_tab_view.dart';
import '../../cubits/tasks_cubit/tasks_cubit.dart';
import '../../models/task_model.dart';
=======
import '../../components/main_drawer.dart';
import '../../components/tasks_tab_view.dart';
import '../../cubits/tasks_cubit/tasks_cubit.dart';
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
            tabs: [
              Tab(text: S.current.upcoming.toUpperCase()),
              Tab(text: S.current.overdue.toUpperCase())
            ],
          ),
        ),
        body: BlocBuilder<TasksCubit, List<TaskModel>>(
          builder: (context, state) {
            return TasksTabView(tasks: state);
=======
            tabs: [Tab(text: S.current.upcoming.toUpperCase()), Tab(text: S.current.overdue.toUpperCase())],
          ),
        ),
        drawer: MainDrawer(),
        body: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            return state.when(
              // TODO use other values
              initial: () => const Placeholder(),
              created: () => const Placeholder(),
              updated: () => const Placeholder(),
              loading: () => const Placeholder(),
              loaded: (values) => TasksTabView(tasks: values),
              failure: (_) => const Placeholder(),
            );
>>>>>>> Stashed changes
          },
        ),
      ),
    );
  }
}
