import 'package:flutter/material.dart';

import '../../../../core/utils.dart';

class DateTile extends StatelessWidget {
  final DateTime date;

  const DateTile(this.date, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Text(
        '${taskDateTileFormatter(context).format(date)}',
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }
}
