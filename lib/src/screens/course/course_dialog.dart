import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../cubits/course_cubit/course_cubit.dart';
import '../../cubits/courses_cubit/courses_cubit.dart';
import '../../models/course_model.dart';
import '../../routes/config_routes.dart';

@immutable
class CourseDialog extends StatelessWidget {
  static const routeName = '/courses/new';

  const CourseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocBuilder<CourseCubit, CourseModel>(
      builder: (context, course) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              course.title == null ? S.current.new_course : '${S.current.editing}: ${course.title}',
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildTitle(context, course),
                    const SizedBox(height: 20),
                    _buildColorPicker(context, course),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'CourseDialog',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                final cubit = context.read<CoursesCubit>();
                if (course.isInBox) {
                  cubit.updateCourse(course);
                } else {
                  cubit.createCourse(course);
                }
                AppRouter.sailor.pop();
                // cubit.state.maybeWhen(
                //   created: () =>
                //   updated: () => AppRouter.sailor.pop(),
                //   orElse: () => null,
                // );
              }
            },
            label: Text(S.current.save),
            icon: const Icon(Icons.save),
          ),
        );
      },
    );
  }

  Widget _buildColorPicker(BuildContext context, CourseModel course) {
    return FormField<Color>(
      initialValue: course.color,
      validator: (value) {
        if (value == null) return S.current.please_choose_a_color;

        return null;
      },
      onSaved: (value) => course.colorValue = value?.value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) => InputDecorator(
        decoration: InputDecoration(
          labelText: S.current.course_color,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          errorText: field.errorText,
        ),
        child: ColorPicker(
          color: field.value ?? Colors.black,
          enableShadesSelection: false,
          padding: const EdgeInsets.all(20),
          runSpacing: 5,
          spacing: 5,
          height: 50,
          width: 50,
          pickersEnabled: const {
            ColorPickerType.primary: true,
            ColorPickerType.accent: false,
            ColorPickerType.both: false,
          },
          onColorChanged: (Color color) => field.didChange(color),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, CourseModel course) {
    return TextFormField(
      initialValue: course.title,
      decoration: InputDecoration(labelText: S.current.course_title),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return S.current.empty_title_error_message;
        } else if (value.length < 2) {
          return S.current.short_title_error_message;
        }
        return null;
      },
      onSaved: (value) => course.title = value ?? course.title,
    );
  }
}
