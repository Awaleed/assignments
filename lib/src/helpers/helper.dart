import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../../generated/l10n.dart';
import 'flash_helper.dart';

abstract class Helpers {
  static void dismissFauces(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Size getWidgetSize(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject();
    return renderBox?.size;
  }

  static bool isArabic(BuildContext context) => Localizations.localeOf(context).languageCode == 'ar';

  static void showErrorOverlay(
    BuildContext context, {
    @required String error,
  }) {
    final message = error;

    if (context == null) return;

    dismissFauces(context);
    final okButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(S.current.back),
    );

    final alert = AlertDialog(
      title: Text(
        '${S.current.an_error_occurred}...',
      ),
      content: Text(message),
      actions: [okButton],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );

    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  static void showErrorDialog(
    BuildContext context, {
    @required dynamic error,
  }) {
    if (context == null) return;

    dismissFauces(context);
    final okButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(S.current.back),
    );

    final messageWidget = <Widget>[];

    if (error['errors'] != null && error['errors'] is Map) {
      final map = error['errors'] as Map;
      for (final entry in map.entries) {
        messageWidget.add(
          Text(
            '${entry.key}',
            style: Theme.of(context).textTheme.headline6,
          ),
        );
        if (entry.value is List) {
          for (final str in entry.value) {
            messageWidget.add(Text('$str'));
          }
        } else {
          messageWidget.add(Text('${entry.value}'));
        }

        messageWidget.add(const Divider());
      }
    } else if (error['error'] != null) {
      messageWidget.add(Text('${error['error']}'));
    } else {
      messageWidget.add(Text('$error'));
    }

    final alert = AlertDialog(
      title: Text(
        '${S.current.an_error_occurred}...',
        locale: const Locale('en', ''),
      ),
      content: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: messageWidget,
          ),
        ),
      ),
      actions: [okButton],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );

    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  static Future<void> showSuccessOverlay(
    BuildContext context, {
    @required String message,
  }) {
    if (context == null) return Future.value();
    final completer = Completer();
    Future.delayed(3.seconds).then((_) => completer.complete());

    FlashHelper.blockSuccessMessage(
      context,
      message: message,
      dismissCompleter: completer,
    );
    return completer.future;
  }

  static Future<void> showMessageOverlay(
    BuildContext context, {
    @required String message,
  }) {
    if (context == null) return Future.value();
    final completer = Completer();
    Future.delayed(3.seconds).then((_) => completer.complete());

    FlashHelper.blockMessage(
      context,
      message: message,
      dismissCompleter: completer,
    );
    return completer.future;
  }

  static DateTime _currentBackPressTime;

  static Future<bool> onWillPop(BuildContext context) {
    final now = DateTime.now();
    if (_currentBackPressTime == null || now.difference(_currentBackPressTime) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Helpers.showMessageOverlay(
        context,
        message: S.current.tap_back_again_to_leave,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  static Completer showLoading(BuildContext context) {
    final completer = Completer();
    if (context != null) {
      FlashHelper.blockDialog(context, dismissCompleter: completer);
    }
    return completer;
  }

  static String mapErrorToMessage(dynamic error) {
    try {
      final String message = '$error';
      return message;
    } catch (e) {
      return '$error';
    }
  }

  // static String _mapDioError(DioError error) {
  //   final message = StringBuffer();
  //   if (error.response?.data['errors'] != null &&
  //       error.response?.data['errors'] is Map) {
  //     final map = error.response?.data['errors'] as Map;
  //     for (final value in map.values) {
  //       if (value is List) {
  //         for (final str in value) {
  //           message.write('$str\n');
  //         }
  //       } else {
  //         message.write('$value\n');
  //       }
  //     }
  //     return message.toString();
  //   } else if (error.response?.data['error'] != null) {
  //     return '${error.response?.data['error']}';
  //   } else {
  //     return '${error.response?.data}';
  //   }
  // }
}
