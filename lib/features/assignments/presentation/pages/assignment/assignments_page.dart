import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../../../../core/routes/router.gr.dart';
import '../../../domain/entities/assignment_entity.dart';
import '../../../domain/entities/class_entity.dart';
import '../../bloc/assignment_bloc/assignment_bloc.dart';

class AssignmentPage extends StatefulWidget {
  AssignmentPage({Key key}) : super(key: key);
  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  AssignmentsBloc _assignmentsBloc;
  List<ClassEntity> classList;
  String classIdFilter;

  @override
  void initState() {
    super.initState();
    classList = [];
    classIdFilter = '';
    _assignmentsBloc = kiwi.Container().resolve<AssignmentsBloc>();
    _assignmentsBloc.add(AssignmentsEvent.getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        actions: <Widget>[
          BlocBuilder<AssignmentsBloc, AssignmentsState>(
            builder: (context, state) {
              return PopupMenuButton<String>(
                itemBuilder: (context) {
                  return state.when(
                    loading: () => [PopupMenuItem(child: Text('Loading...'))],
                    loaded: (classList) {
                      final items = [
                        PopupMenuItem<String>(
                          child: Text('All'),
                          value: '',
                        )
                      ];
                      items.addAll(
                        (classList).map(
                          (c) => PopupMenuItem<String>(
                            child: Text('${c.name}'),
                            value: c.id,
                          ),
                        ),
                      );
                      return items;
                    },
                  );
                },
                initialValue: '',
                onSelected: (value) => setState(() => classIdFilter = value),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<AssignmentsBloc, AssignmentsState>(
        builder: (context, state) {
          return state.when(
            loading: () => Center(child: CircularProgressIndicator()),
            loaded: (classList) {
              this.classList = classList;
              return _buildAssignmentsList(classList);
            },
          );
        },
      ),
      floatingActionButton: BlocBuilder<AssignmentsBloc, AssignmentsState>(
        builder: (context, state) {
          return state.when(
            loading: () => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: null,
            ),
            loaded: (_) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _onAddAssignment(),
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
        if (classIdFilter.isNotEmpty && entity.id != classIdFilter) return;
        entity.assignments.forEach((assignment) {
          if (assignment.completed) return;
          assignmentList.add(assignment.copyWith(classEntity: entity));
        });
      },
    );

    if (assignmentList.isEmpty) {
      return Center(child: Text('Add New Assignment'));
    }

    final list = _bulidAssignments(assignmentList);

    return ListView(
      children: list,
    );
  }

  _bulidAssignments(List<AssignmentEntity> assignmentList) {
    List<Widget> overdue = [];
    List<Widget> toDay = [];
    List<Widget> tommorrow = [];
    List<Widget> thisWeek = [];
    List<Widget> future = [];

    assignmentList.forEach((entity) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final delivery = entity.dueDate;
      final daysLeft = delivery.difference(today).inDays;
      final dateFormatter = (DateTime date) {
        return '${date.month}/${date.day < 9 ? '0' + date.day.toString() : date.day}';
      };
      final widget = Dismissible(
        key: ObjectKey(entity),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            ListTile(
              onTap: () => _onShowAssignmentDetails(entity),
              title: Text('${entity.name}'),
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
        background: Container(color: Colors.green),
        onDismissed: (_) => _onCompleate(entity),
      );

      if (daysLeft < 0) return overdue.add(widget);
      if (daysLeft == 0) return toDay.add(widget);
      if (daysLeft == 1) return tommorrow.add(widget);
      if (daysLeft <= 7) return thisWeek.add(widget);
      if (daysLeft > 7) return future.add(widget);
    });

    final labelTile = (label) {
      return Container(
        padding: EdgeInsets.only(left: 16),
        color: Theme.of(context).accentColor,
        height: 30,
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    };

    if (overdue.isNotEmpty) overdue.insert(0, labelTile('Overdue'));
    if (toDay.isNotEmpty) toDay.insert(0, labelTile('Today'));
    if (tommorrow.isNotEmpty) tommorrow.insert(0, labelTile('Tomorrow'));
    if (thisWeek.isNotEmpty) thisWeek.insert(0, labelTile('This week'));
    if (future.isNotEmpty) future.insert(0, labelTile('Future'));

    final _sorted = overdue + toDay + tommorrow + thisWeek + future;
    return _sorted;
  }

  _onAddAssignment() async {
    final newAssignment = await Router.navigator.pushNamed(
      Routes.assignmentDialog,
      arguments: AssignmentDialogArguments(
        classList: classList,
      ),
    );
    if (newAssignment != null) {
      _assignmentsBloc.add(AssignmentsEvent.addAssignment(newAssignment));
    }
  }

  _onShowAssignmentDetails(AssignmentEntity assignment) {
    Router.navigator.pushNamed(
      Routes.assignmentDetails,
      arguments: AssignmentDetailsArguments(
        entity: assignment,
        onDelete: _onDeleteAssignment,
        onEdit: _onEditAssignment,
      ),
    );
  }

  _onDeleteAssignment(AssignmentEntity deletedAssignment) async {
    _assignmentsBloc.add(AssignmentsEvent.deleteAssignment(deletedAssignment));
  }

  _onEditAssignment(AssignmentEntity entity) async {
    final updatedAssignment = await Router.navigator.pushNamed(
      Routes.assignmentDialog,
      arguments: AssignmentDialogArguments(
        classList: classList,
        assignment: entity,
      ),
    );
    _assignmentsBloc.add(AssignmentsEvent.updateAssignment(updatedAssignment));
    _onShowAssignmentDetails(updatedAssignment);
  }

  _onCompleate(AssignmentEntity entity) {
    _assignmentsBloc.add(AssignmentsEvent.toggoleAssignment(entity));
    _assignmentsBloc.add(AssignmentsEvent.getData());
  }
}
