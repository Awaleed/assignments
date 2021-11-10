import 'package:intl/intl.dart';

import '../../generated/l10n.dart';

abstract class Formatters {
  static DateFormat get taskDateAtTimeFormatter => DateFormat("EEEE, d, MMM '${S.current.at}' K:mm a");

  static String taskDateAtTime(DateTime date) => taskDateAtTimeFormatter.format(date);

  static String taskTime(DateTime date) => DateFormat('K:mm a').format(date);

  static String taskDateTile(DateTime date) => DateFormat('EEE, MMM, dd, yyyy').format(date);
}
