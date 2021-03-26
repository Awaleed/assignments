import 'package:assignments/generated/l10n.dart';
import 'package:assignments/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/course_tile.dart';
import '../../components/main_drawer.dart';
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
      appBar: AppBar(
        title: Text(S.current.courses),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          return state.when(
            // TODO use other values
            initial: () => const Placeholder(),
            loading: () => const Placeholder(),
            created: () => const Placeholder(),
            updated: () => const Placeholder(),
            deleted: () => const Placeholder(),
            loaded: (values) => _buildCoursesList(values),
            failure: (_) => const Placeholder(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await AppRouter.sailor.navigate(
            CourseDialog.routeName,
            params: {'course': CourseModel()},
          );
          context.read<CoursesCubit>().getAllCourses();
        },
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
