import 'dart:math';

import 'package:assignments/features/assignments/domain/entities/course_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routes/router.gr.dart';
import '../../widgets/color_picker.dart';

class CourseDialog extends StatefulWidget {
  final CourseEntity course;

  const CourseDialog({Key key, this.course}) : super(key: key);
  @override
  _CourseDialogState createState() => _CourseDialogState();
}

class _CourseDialogState extends State<CourseDialog> {
  final _formKey = GlobalKey<FormState>();

  bool edit;

  TextEditingController titleController;
  String title;
  Color color;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          edit ? 'Editing: ${widget.course.name}' : 'New Course',
        ),
      ),
      body: Form(
        key: _formKey,
        onWillPop: () async => await _onWillPop(),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Course title',
                  filled: true,
                ),
                style: theme.textTheme.headline,
                controller: titleController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (String value) {
                  title = value;
                },
              ),
            ),
            Expanded(
              child: BlockPicker(
                onColorChanged: (Color value) {
                  setState(() {
                    color = value;
                  });
                },
                pickerColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: color,
        onPressed: () => _onSave(),
      ),
    );
  }

  setValues() {
    final classEntity = widget.course;

    if (classEntity != null) {
      title = classEntity.name;
      titleController.text = title;
      color = classEntity.color;

      edit = true;
    } else {
      color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
      edit = false;
    }
  }

  _onSave() {
    if (_formKey.currentState.validate()) {
      final CourseEntity entity = CourseEntity(
        id: widget?.course?.id,
        name: title,
        color: color,
      );
      Router.navigator.pop<CourseEntity>(entity);
    }
  }

  _onWillPop() async {
    if (title == null) {
      return true;
    }
    bool pop = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dismiss Changes"),
          content: Text("Data Is not Saved??"),
          actions: <Widget>[
            FlatButton(
              child: Text("Continue"),
              onPressed: () {
                Router.navigator.pop();
              },
            ),
            FlatButton(
              child: Text("Dismiss"),
              onPressed: () {
                Router.navigator.pop();
                pop = true;
              },
            ),
          ],
        );
      },
    );
    return pop;
  }
}
