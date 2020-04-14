import 'package:flutter/material.dart';

class AssignmentListSeparator extends StatelessWidget {
  final String title;

  const AssignmentListSeparator({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      color: Theme.of(context).accentColor,
      height: 30,
      alignment: Alignment.centerLeft,
      child: Text(
        '$title',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
