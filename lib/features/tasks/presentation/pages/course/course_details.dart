import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/utils.dart';
import '../../../domain/entities/course_entity.dart';
import '../../../domain/entities/task_entity.dart';
import '../../helpers.dart';
import '../../widgets/tasks_tab_view.dart';

class CourseDetails extends StatefulWidget {
  final Course course;
  const CourseDetails({
    Key key,
    @required this.course,
  }) : super(key: key);

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails>
    with SingleTickerProviderStateMixin, Helpers {
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
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: loc.tasks.upcoming.toUpperCase()),
            Tab(text: loc.tasks.overdue.toUpperCase())
          ],
        ),
        title: Text(widget.course.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => Helpers.onDeleteCourse(widget.course),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Helpers.onShowCourseDialog(course: widget.course),
          )
        ],
      ),
      body: Observer(
        builder: (_) => TasksTabView(
          overdue: Helpers.store.overdueTasks.filterByClassId(widget.course.id),
          upcoming:
              Helpers.store.pendingTasks.filterByClassId(widget.course.id),
          tabController: _tabController,
          onAddTask: () => Helpers.onShowTaskDialog(
            course: widget.course,
            fixedCourse: true,
          ),
        ),
      ),
    );
  }
}

extension on List<Task> {
  List<Task> filterByClassId(int id) {
    return where((t) => t.course.id == id).toList();
  }
}
