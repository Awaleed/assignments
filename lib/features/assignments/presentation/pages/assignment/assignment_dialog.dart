import 'dart:async';

import 'package:assignments/core/custom_types/custom_types.dart';
import 'package:assignments/core/routes/router.gr.dart';
import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:assignments/features/assignments/domain/entities/class_entity.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:uuid/uuid.dart';

class AssignmentDialog extends StatefulWidget {
  final AssignmentEntity assignment;
  final List<ClassEntity> classList;
  const AssignmentDialog({
    Key key,
    @required this.classList,
    this.assignment,
  }) : super(key: key);
  @override
  NewCoureseDialogState createState() => NewCoureseDialogState();
}

class NewCoureseDialogState extends State<AssignmentDialog> {
  final _formKey = GlobalKey<FormState>();

  AssignmentType _type;

  String _id;
  String _name;
  ClassEntity _classEntity;

  DateTime _dueDate;
  String _notes;
  bool _completed = false;

  Color _color = Colors.deepPurple;
  bool _edit = false;

  TextEditingController _nameController;
  TextEditingController _notesController;
  String _title;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _notesController = TextEditingController();
    _setValues();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(
          _edit ? 'Editing: $_title' : 'New assignment',
        ),
      ),
      body: Form(
        key: _formKey,
        onWillPop: () async => await _onWillPop(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Assignment name',
                    filled: true,
                  ),
                  style: theme.textTheme.headline,
                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Class',
                    filled: true,
                  ),
                  style: theme.textTheme.headline,
                  value: _classEntity,
                  validator: (value) {
                    if (value == null) {
                      return 'Please choose one';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _classEntity = value;
                      _color = _classEntity.color;
                    });
                  },
                  items: widget.classList
                      .map(
                        (classEntity) => DropdownMenuItem<ClassEntity>(
                          child: Text('${classEntity.name}'),
                          value: classEntity,
                        ),
                      )
                      .toList(),
                ),
              ),
              _DateTimePicker(
                labelText: 'Due Date',
                selectedDate: _dueDate,
                color: Colors.green,
                selectDate: (DateTime date) {
                  setState(() {
                    _dueDate = date;
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    filled: true,
                  ),
                  minLines: 2,
                  maxLines: 10,
                  style: theme.textTheme.headline,
                  controller: _notesController,
                  onChanged: (String value) {
                    setState(() {
                      _notes = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: _color,
        onPressed: () => _onSave(),
      ),
    );
  }

  void _setValues() {
    final assignment = widget.assignment;
    // kiwi.Container().resolve<ClassBloc>().add(GetClasses());

    if (assignment != null) {
      _type = assignment.type;

      _name = assignment.name;
      _classEntity = assignment.classEntity;
      _dueDate = assignment.dueDate;
      _notes = assignment.notes;
      _completed = assignment.completed;

      _edit = true;
      _title = _name;
      _color = _classEntity.color;
      _nameController.text = assignment.name;
      _notesController.text = assignment.notes;
    } else {
      final now = DateTime.now();
      _id = '';

      _name = '';
      _dueDate = DateTime(now.year, now.month, now.day);
      _notes = '';
      _completed = false;

      _edit = false;
      _color = Colors.blue;
      _nameController.text = '';
      _notesController.text = '';
    }
  }

  _onSave() {
    if (_formKey.currentState.validate()) {
      final entity = AssignmentEntity(
        id: Uuid().v1(),
        name: _name,
        type: AssignmentType.homework,
        classEntity: _classEntity,
        dueDate: _dueDate,
        notes: _notes,
        completed: _completed,
      );

      Router.navigator.pop<AssignmentEntity>(entity);
    }
  }

  _onWillPop() async {
    if (_name.isEmpty) {
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

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime,
    this.color,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;
  final Color color;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Theme(
            data: ThemeData(primarySwatch: color),
            child: _InputDropdown(
              labelText: labelText,
              valueText: selectedDate.toString(),
              valueStyle: valueStyle,
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
        ),
        const SizedBox(width: 12.0),
      ],
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed,
  }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade700
                  : Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
