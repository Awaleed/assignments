import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:assignments/features/assignments/presentation/pages/assignment/widgets/assignment_list_separator.dart';
import 'package:assignments/features/assignments/presentation/pages/assignment/widgets/assignment_list_tile.dart';
import 'package:flutter/material.dart';

class AssignmentListView extends StatelessWidget {
  final List<AssignmentEntity> assignmentList;
  final bool separated;

  const AssignmentListView({
    Key key,
    @required this.assignmentList,
    this.separated = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final list = separated ? _buildSeparatedAssignments() : _buildAssignments();

    return ListView(
      children: list,
    );
  }

  _buildAssignments() => assignmentList
      .map((assignment) => AssignmentListTile(assignment: assignment))
      .toList();

  _buildSeparatedAssignments() {
    List<Widget> overdue = [];
    List<Widget> toDay = [];
    List<Widget> tomorrow = [];
    List<Widget> thisWeek = [];
    List<Widget> future = [];

    assignmentList.forEach((assignment) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final delivery = assignment.dueDate;
      final daysLeft = delivery.difference(today).inDays;

      final assignmentTile = AssignmentListTile(assignment: assignment);

      if (daysLeft < 0)
        return overdue.add(assignmentTile);
      else if (daysLeft == 0)
        return toDay.add(assignmentTile);
      else if (daysLeft == 1)
        return tomorrow.add(assignmentTile);
      else if (daysLeft <= 7)
        return thisWeek.add(assignmentTile);
      else if (daysLeft > 7) return future.add(assignmentTile);
    });

    if (overdue.isNotEmpty)
      overdue.insert(
        0,
        AssignmentListSeparator(title: 'Overdue'),
      );
    if (toDay.isNotEmpty)
      toDay.insert(
        0,
        AssignmentListSeparator(title: 'Today'),
      );
    if (tomorrow.isNotEmpty)
      tomorrow.insert(
        0,
        AssignmentListSeparator(title: 'Tomorrow'),
      );
    if (thisWeek.isNotEmpty)
      thisWeek.insert(
        0,
        AssignmentListSeparator(title: 'This week'),
      );
    if (future.isNotEmpty)
      future.insert(
        0,
        AssignmentListSeparator(title: 'Future'),
      );

    final _sorted = overdue + toDay + tomorrow + thisWeek + future;
    return _sorted;
  }
}
