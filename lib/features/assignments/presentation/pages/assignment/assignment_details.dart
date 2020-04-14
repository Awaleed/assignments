import 'package:assignments/core/routes/router.gr.dart';
import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:assignments/features/assignments/presentation/store/assignments.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class AssignmentDetails extends StatelessWidget {
  final AssignmentEntity assignment;
  final store = kiwi.Container().resolve<AssignmentsStore>();

  AssignmentDetails({
    Key key,
    @required this.assignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fab = FloatingActionButton(
      child: Icon(Icons.edit),
      backgroundColor: assignment.course.color,
      onPressed: () async {
        await _onEditAssignment();
        Router.navigator.pop();
      },
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: assignment.course.color,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(assignment.name),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    store.deleteAssignment(assignment);
                    Router.navigator.pop();
                  },
                )
              ],
              // bottom: PreferredSize(
              //   child: widget(
              //     child: Stack(
              //       fit: StackFit.expand,
              //       alignment: Alignment.centerLeft,
              //       children: <Widget>[_fab],
              //     ),
              //   ),
              //   preferredSize: null,
              // ),
            ),
          ];
        },
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
      floatingActionButton: _fab,
    );
  }

  _onEditAssignment() async {
    final updatedAssignment = await Router.navigator.pushNamed(
      Routes.assignmentDialog,
      arguments: AssignmentDialogArguments(
        assignment: assignment,
      ),
    );
    if (updatedAssignment != null) {
      store.updateAssignment(updatedAssignment);
    }

    Router.navigator.pushNamed(
      Routes.assignmentDetails,
      arguments: AssignmentDetailsArguments(
        assignment: updatedAssignment,
      ),
    );
  }
}
