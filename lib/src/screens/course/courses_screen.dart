import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../components/course_tile.dart';
<<<<<<< Updated upstream
=======
import '../../components/main_drawer.dart';
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
      appBar: AppBar(title: Text(S.current.courses), centerTitle: true),
      body: BlocBuilder<CoursesCubit, List<CourseModel>>(
        builder: (context, state) => _buildCoursesList(state),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'Courses$hashCode',
        onPressed: () =>
            AppRouter.sailor.navigate(CourseDialog.routeName, params: {'course_cubit': null}),
=======
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
>>>>>>> Stashed changes
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
