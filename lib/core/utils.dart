import 'package:assignments/generated/locale_base.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat taskDateAtTimeFormatter(BuildContext context) {
  return DateFormat("EEEE, d, MMM '${localeBase(context).tasks.at}' K:mm a",
      locale(context).languageCode);
}

DateFormat taskTimeFormatter(BuildContext context) {
  return DateFormat('K:mm a', locale(context).languageCode);
}

DateFormat taskDateTileFormatter(BuildContext context) {
  return DateFormat('EEE, MMM, dd, yyyy', locale(context).languageCode);
}

Locale locale(BuildContext context) => Localizations.localeOf(context);
LocaleBase localeBase(BuildContext context) =>
    Localizations.of<LocaleBase>(context, LocaleBase);
