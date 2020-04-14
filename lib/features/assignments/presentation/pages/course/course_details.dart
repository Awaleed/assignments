import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../../../../core/routes/router.gr.dart';
import '../../../domain/entities/course_entity.dart';
import '../../store/assignments.dart';

class CourseDetails extends StatelessWidget {
  final store = kiwi.Container().resolve<AssignmentsStore>();

  final CourseEntity course;

  CourseDetails({
    Key key,
    @required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fab = FloatingActionButton(
      child: Icon(Icons.edit),
      backgroundColor: course.color,
      onPressed: () async {
        await _onEditCourse();
        Router.navigator.pop();
      },
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: course.color,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(course.name),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    store.deleteCourse(course);
                    Router.navigator.pop();
                  },
                )
              ],
              // bottom: PreferredSize(
              //   child: widget(
              //     child: Stack(
              //       fit: StackFit.expand,
              //       alignment: Alignment.centerLeft,
              //       children: <Widget>[_fab],
              //     ),
              //   ),
              //   preferredSize: null,
              // ),
            ),
          ];
        },
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
      floatingActionButton: _fab,
    );
  }

  _onEditCourse() async {
    final course = await Router.navigator.pushNamed(
      Routes.courseDialog,
      arguments: CourseDialogArguments(
        course: this.course,
      ),
    );

    if (course != null) {
      store.updateCourse(course);
    }

    Router.navigator.pushNamed(
      Routes.courseDetails,
      arguments: CourseDetailsArguments(
        course: course,
      ),
    );
  }
}
