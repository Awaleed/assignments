import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../../../../core/routes/router.gr.dart';
import '../../../domain/entities/course_entity.dart';
import '../../store/assignments.dart';

class CoursesPage extends StatelessWidget {
  final store = kiwi.Container().resolve<AssignmentsStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: Observer(builder: (_) => _buildCoursesListView(store.courses)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onAddCourse(),
      ),
    );
  }

  Widget _buildCoursesListView(courses) {
    if (courses.isEmpty) {
      return Center(child: Text('Add New course'));
    }

    return ListView.separated(
      itemCount: courses.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        final course = courses[index];

        return ListTile(
          onTap: () => _onShowDetails(course),
          title: Text(course.name),
          leading: CircleAvatar(backgroundColor: course.color),
        );
      },
    );
  }

  _onAddCourse() async {
    final course = await Router.navigator.pushNamed(Routes.courseDialog);
    if (course != null) {
      store.addCourse(course);
    }
  }

  _onShowDetails(CourseEntity course) async {
    Router.navigator.pushNamed(
      Routes.courseDetails,
      arguments: CourseDetailsArguments(
        course: course,
      ),
    );
  }
}
