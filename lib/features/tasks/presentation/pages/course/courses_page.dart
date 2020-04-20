import 'package:assignments/core/utils.dart';
import 'package:assignments/generated/locale_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../helpers.dart';
import '../../widgets/course_tile.dart';
import '../../widgets/main_drawer.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocaleBase loc = localeBase(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${loc.courses.courses}'),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Observer(
        builder: (_) {
          final courses = Helpers.store.courses;
          if (courses.isEmpty) {
            return Center(child: Text('${loc.courses.empty_courses_list}'));
          } else {
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CourseTile(
                  courses[index],
                  onTap: () => Helpers.onShowCourseDetails(courses[index]),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Helpers.onShowCourseDialog(),
        label: Text('${loc.courses.new_course}'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
