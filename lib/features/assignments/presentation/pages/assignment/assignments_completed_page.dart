import 'package:assignments/features/assignments/presentation/pages/assignment/widgets/assignment_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../store/assignments.dart';

class AssignmentCompletedPage extends StatelessWidget {
  final store = kiwi.Container().resolve<AssignmentsStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed'),
      ),
      body: Observer(
        builder: (_) {
          if (store.completedAssignments.isEmpty)
            return Center(child: Text('Add New Assignment'));
          return AssignmentListView(assignmentList: store.completedAssignments);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () => store.deleteCompletedAssignments(),
      ),
    );
  }
}
