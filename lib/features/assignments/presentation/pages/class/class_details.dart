import 'package:flutter/material.dart';

import '../../../../../core/routes/router.gr.dart';
import '../../../domain/entities/class_entity.dart';

class ClassDetails extends StatelessWidget {
  final ClassEntity entity;
  final Function onEdit;
  final Function onDelete;

  ClassDetails({
    Key key,
    this.entity,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fab = FloatingActionButton(
      child: Icon(Icons.edit),
      backgroundColor: entity.color,
      onPressed: () async {
        await onEdit(entity);
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
              backgroundColor: entity.color,
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
