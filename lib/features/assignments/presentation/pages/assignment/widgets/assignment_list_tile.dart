import 'package:assignments/core/routes/router.gr.dart';
import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:assignments/features/assignments/presentation/store/assignments.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class AssignmentListTile extends StatelessWidget {
  final AssignmentEntity assignment;
  final store = kiwi.Container().resolve<AssignmentsStore>();

  AssignmentListTile({
    Key key,
    @required this.assignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(assignment),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          ListTile(
            onTap: () => _onShowDetails(),
            title: Text('${assignment.name}'),
            subtitle: Text(
              assignment.notes,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(_formatDate(assignment.dueDate)),
          ),
          Container(
            height: 82,
            width: 7,
            color: assignment.course.color,
          )
        ],
      ),
      background: Container(
        color: assignment.completed ? Colors.red : Colors.green,
      ),
      onDismissed: (_) => _onToggle(),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.month}/${date.day < 9 ? '0' + date.day.toString() : date.day}';

  _onShowDetails() {
    Router.navigator.pushNamed(
      Routes.assignmentDetails,
      arguments: AssignmentDetailsArguments(
        assignment: assignment,
      ),
    );
  }

  _onToggle() {
    store.toggleAssignment(assignment);
  }
}
