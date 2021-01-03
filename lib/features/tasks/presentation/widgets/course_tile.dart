import 'package:flutter/material.dart';

import '../../domain/entities/course_entity.dart';

@immutable
class CourseTile extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseTile(
    this.course, {
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(course.title),
        // subtitle: Text('CS102'),
        trailing: CircleAvatar(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: course.color,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
