import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../components/course_tile.dart';
import '../../cubits/courses_cubit/courses_cubit.dart';
import '../../models/course_model.dart';
import '../../routes/config_routes.dart';
import 'course_dialog.dart';

class CoursesScreen extends StatelessWidget {
  static const routeName = '/courses';
  const CoursesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.courses), centerTitle: true),
      body: BlocBuilder<CoursesCubit, List<CourseModel>>(
        builder: (context, state) => _buildCoursesList(state),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'Courses$hashCode',
        onPressed: () =>
            AppRouter.sailor.navigate(CourseDialog.routeName, params: {'course_cubit': null}),
        label: Text(S.current.new_course),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCoursesList(List<CourseModel> values) {
    if (values.isEmpty) {
      return Center(child: Text(S.current.empty_courses_list));
    } else {
      return ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, index) => CourseTile(course: values[index]),
      );
    }
  }
}
