import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../generated/l10n.dart';
import '../../init_injectable.dart';
import '../repositories/settings_repository.dart';
import 'dialogs_helpers.dart';
import 'flash_helper.dart';

abstract class Helpers {
  static intl.NumberFormat moneyFormatter = intl.NumberFormat('#,##0.00', 'en_US');

  static void dismissFauces(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool get isArabic => getIt<ISettingsRepository>().getSettings().languageCode == 'ar';

  static DateTime? _currentBackPressTime;

  static Future<bool> onWillPop(BuildContext context, [void Function()? notReadyCallback]) {
    final now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      notReadyCallback?.call();
      DialogsHelpers.showMessageOverlay(
        context,
        S.current.tap_back_again_to_leave,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  static Completer showLoading(BuildContext context) {
    final completer = Completer();
    FlashHelper.blockDialog(context, dismissCompleter: completer);
    return completer;
  }
}
