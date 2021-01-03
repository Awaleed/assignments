import 'package:flutter/material.dart';

import '../../../../../core/utils.dart';
import '../../../../../generated/locale_base.dart';
import '../../../domain/entities/course_entity.dart';
import '../../helpers.dart';
import '../../widgets/color_picker.dart';

@immutable
class CourseDialog extends StatefulWidget {
  final Course course;

  const CourseDialog({
    Key key,
    @required this.course,
  }) : super(key: key);

  @override
  _CourseDialogState createState() => _CourseDialogState();
}

class _CourseDialogState extends State<CourseDialog> {
  GlobalKey<FormState> formKey;
  LocaleBase loc;
  Course course;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    course = widget.course;
  }

  @override
  Widget build(BuildContext context) {
    loc = localeBase(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          course.title == null
              ? loc.courses.new_course
              : '${loc.courses.editing}: ${course.title}',
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
        onPressed: () => Helpers.onSaveCourse(
          formKey: formKey,
          course: course,
        ),
        label: Text(loc.courses.save),
        icon: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildColorPicker() {
    return InputDecorator(
      decoration: InputDecoration(labelText: loc.courses.course_color),
      child: BlockPicker(
        onColorChanged: (value) => course.colorIndex = Helpers.mapColor(value),
        pickerColor: course.color,
      ),
    );
  }

  Widget _buildTitle() {
    return TextFormField(
      initialValue: course.title,
      decoration: InputDecoration(
        labelText: loc.courses.course_title,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return loc.courses.empty_title_error_message;
        } else if (value.length <= 2) {
          return loc.courses.short_title_error_message;
        }
        return null;
      },
      onChanged: (value) => course.title = value,
    );
  }
}
