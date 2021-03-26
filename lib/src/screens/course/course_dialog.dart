import 'package:assignments/generated/l10n.dart';
import 'package:assignments/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/color_picker.dart';
import '../../cubits/courses_cubit/courses_cubit.dart';
import '../../models/course_model.dart';
import '../../routes/config_routes.dart';

@immutable
class CourseDialog extends StatelessWidget {
  static const routeName = '/courses/new';

  final CourseModel course;

  const CourseDialog({
    Key key,
    @required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          course.title == null
              ? S.current.new_course
              : '${S.current.editing}: ${course.title}',
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          onWillPop: () => Helpers.onWillPop(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTitle(),
                const SizedBox(height: 20),
                _buildColorPicker(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            if (course.isInBox) {
              context.read<CoursesCubit>()
                ..updateCourse(course)
                ..listen((state) => state.maybeWhen(
                      updated: () => AppRouter.sailor.pop(),
                      orElse: () => null,
                    ));
            } else {
              context.read<CoursesCubit>()
                ..createCourse(course)
                ..listen((state) => state.maybeWhen(
                      created: () => AppRouter.sailor.pop(),
                      orElse: () => null,
                    ));
            }
          }
        },
        label: Text(S.current.save),
        icon: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildColorPicker() {
    return InputDecorator(
      decoration: InputDecoration(labelText: S.current.course_color),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlockPicker(
          onColorChanged: (value) => course.colorValue = value.value,
          pickerColor: course.color,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return TextFormField(
      initialValue: course.title,
      decoration: InputDecoration(
        labelText: S.current.course_title,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value.isEmpty) {
          return S.current.empty_title_error_message;
        } else if (value.length <= 2) {
          return S.current.short_title_error_message;
        }
        return null;
      },
      onSaved: (value) => course.title = value,
    );
  }
}
