import 'package:assignments/features/assignments/presentation/pages/assignment/widgets/assignment_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../../../../core/routes/router.gr.dart';
import '../../store/assignments.dart';

class AssignmentPage extends StatelessWidget {
  final store = kiwi.Container().resolve<AssignmentsStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        // actions: <Widget>[
        //   BlocBuilder<AssignmentsBloc, AssignmentsState>(
        //     builder: (context, state) {
        //       return PopupMenuButton<String>(
        //         itemBuilder: (context) {
        //           return state.when(
        //             loading: () => [PopupMenuItem(child: Text('Loading...'))],
        //             loaded: (classList) {
        //               final items = [
        //                 PopupMenuItem<String>(
        //                   child: Text('All'),
        //                   value: '',
        //                 )
        //               ];
        //               items.addAll(
        //                 (classList).map(
        //                   (c) => PopupMenuItem<String>(
        //                     child: Text('${c.name}'),
        //                     value: c.id,
        //                   ),
        //                 ),
        //               );
        //               return items;
        //             },
        //           );
        //         },
        //         initialValue: '',
        //         onSelected: (value) => setState(() => classIdFilter = value),
        //       );
        //     },
        //   )
        // ],
      ),
      body: Observer(
        builder: (_) {
          if (store.assignments.isEmpty)
            return Center(child: Text('Add New Assignment'));
          return AssignmentListView(assignmentList: store.pendingAssignments);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onAddAssignment(),
      ),
    );
  }

  _onAddAssignment() async {
    final newAssignment =
        await Router.navigator.pushNamed(Routes.assignmentDialog);
    if (newAssignment != null) {
      store.addAssignment(newAssignment);
    }
  }
}
