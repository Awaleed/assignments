import 'package:flutter/material.dart';

import '../models/course_model.dart';
import '../routes/config_routes.dart';
import '../screens/course/course_details.dart';

@immutable
class CourseTile extends StatelessWidget {
  const CourseTile({
<<<<<<< Updated upstream
    required this.course,
    Key? key,
=======
    this.course,
    Key key,
>>>>>>> Stashed changes
  }) : super(key: key);

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
<<<<<<< Updated upstream
        title: Text(course.title!),
=======
        title: Text(course.title),
        // subtitle: Text('CS102'),
>>>>>>> Stashed changes
        trailing: CircleAvatar(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: course.color,
            ),
          ),
        ),
        onTap: () => AppRouter.sailor.navigate(
          CourseDetailsScreen.routeName,
          params: {'course': course},
        ),
      ),
    );
  }
}
