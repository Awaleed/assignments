import 'package:assignments/core/routes/router.gr.dart';
import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:flutter/material.dart';

class AssignmentDetails extends StatelessWidget {
  final AssignmentEntity entity;
  final Function onEdit;
  final Function onDelete;

  const AssignmentDetails({
    Key key,
    this.entity,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fab = FloatingActionButton(
      child: Icon(Icons.edit),
      backgroundColor: entity.classEntity.color,
      onPressed: () async {
        await onEdit(entity: entity);
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
              backgroundColor: entity.classEntity.color,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(entity.name),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await onDelete(entity);
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
}
