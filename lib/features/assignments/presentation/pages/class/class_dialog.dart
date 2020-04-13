import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/routes/router.gr.dart';
import '../../../domain/entities/assignment_entity.dart';
import '../../../domain/entities/class_entity.dart';
import '../../widgets/color_picker.dart';

class ClassDialog extends StatefulWidget {
  final ClassEntity classEntity;

  const ClassDialog({Key key, this.classEntity}) : super(key: key);
  @override
  _ClassDialogState createState() => _ClassDialogState();
}

class _ClassDialogState extends State<ClassDialog> {
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
          edit ? 'Editing: ${widget.classEntity.name}' : 'New Course',
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
    final classEntity = widget.classEntity;

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
      final ClassEntity entity = ClassEntity(
        id: widget?.classEntity?.id,
        name: title,
        color: color,
        assignments: <AssignmentEntity>[],
      );
      Router.navigator.pop<ClassEntity>(entity);
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
          title: Text("Dissmiss Changes"),
          content: Text("Data Is not Saved??"),
          actions: <Widget>[
            FlatButton(
              child: Text("Continue"),
              onPressed: () {
                Router.navigator.pop();
              },
            ),
            FlatButton(
              child: Text("Dissmiss"),
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
