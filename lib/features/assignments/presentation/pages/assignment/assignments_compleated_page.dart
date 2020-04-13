import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../../domain/entities/assignment_entity.dart';
import '../../../domain/entities/class_entity.dart';
import '../../bloc/assignment_bloc/assignment_bloc.dart';

class AssignmentCompleatedPage extends StatefulWidget {
  AssignmentCompleatedPage({Key key}) : super(key: key);
  @override
  _AssignmentCompleatedPageState createState() =>
      _AssignmentCompleatedPageState();
}

class _AssignmentCompleatedPageState extends State<AssignmentCompleatedPage> {
  AssignmentsBloc _assignmentsBloc;

  @override
  void initState() {
    super.initState();
    _assignmentsBloc = kiwi.Container().resolve<AssignmentsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compleated'),
      ),
      body: BlocBuilder<AssignmentsBloc, AssignmentsState>(
        builder: (context, state) {
          return state.when(
            loading: () => CircularProgressIndicator(),
            loaded: (classList) => _buildAssignmentsList(classList),
          );
        },
      ),
      floatingActionButton: BlocBuilder<AssignmentsBloc, AssignmentsState>(
        builder: (context, state) {
          return state.when(
            loading: () => FloatingActionButton(
              child: Icon(Icons.delete),
              onPressed: null,
            ),
            loaded: (classList) => FloatingActionButton(
              child: Icon(Icons.delete),
              onPressed: () => _onClearDoneAssignment(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAssignmentsList(List<ClassEntity> classList) {
    final assignmentList = <AssignmentEntity>[];

    classList.forEach(
      (entity) {
        entity.assignments.forEach((assignment) {
          if (!assignment.completed) return;
          assignmentList.add(assignment.copyWith(classEntity: entity));
        });
      },
    );

    if (assignmentList.isEmpty) {
      return Center(child: Text('Nothing Done'));
    }

    List<Widget> tiles = [];

    assignmentList.forEach((entity) {
      if (!entity.completed) return;
      final dateFormatter = (DateTime date) {
        return '${date.month}/${date.day < 9 ? '0' + date.day.toString() : date.day}';
      };
      final widget = Dismissible(
        key: ObjectKey(entity),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            ListTile(
              title: Text(entity.name),
              subtitle: Text(
                entity.notes,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(dateFormatter(entity.dueDate)),
            ),
            Container(
              height: 82,
              width: 7,
              color: entity.classEntity.color,
            )
          ],
        ),
        background: Container(color: Colors.red),
        onDismissed: (_) => _onCompleate(entity),
      );

      tiles.add(widget);
    });

    return ListView(
      children: tiles,
    );
  }

  _onCompleate(AssignmentEntity entity) {
    _assignmentsBloc.add(AssignmentsEvent.toggoleAssignment(entity));
    _assignmentsBloc.add(AssignmentsEvent.getData());
  }

  _onClearDoneAssignment() async {
    _assignmentsBloc.add(AssignmentsEvent.deleteCompleatedAssignments());
  }
}
