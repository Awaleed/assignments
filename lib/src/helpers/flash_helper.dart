import 'dart:async';
import 'dart:collection';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _MessageItem<T> {
  _MessageItem(this.message) : completer = Completer<Future<T>>();

  final String message;
  Completer<Future<T>> completer;
}

class FlashHelper {
  static Completer<BuildContext> _buildCompleter = Completer<BuildContext>();
  static final _messageQueue = Queue<_MessageItem>();
  static Completer _previousCompleter;

  static void init(BuildContext context) {
    if (_buildCompleter?.isCompleted == false) {
      _buildCompleter.complete(context);
    }
  }

  static void dispose() {
    _messageQueue.clear();

    if (_buildCompleter?.isCompleted == false) {
      _buildCompleter.completeError('NotInitialized');
    }
    _buildCompleter = Completer<BuildContext>();
  }

  static Future<T> toast<T>(String message) async {
    final context = await _buildCompleter.future;

    // Wait previous toast dismissed.
    if (_previousCompleter?.isCompleted == false) {
      final item = _MessageItem<T>(message);
      _messageQueue.add(item);
      return await item.completer.future;
    }

    _previousCompleter = Completer();

    Future<T> showToast(String message) {
      return showFlash<T>(
        context: context,
        builder: (context, controller) {
          return Flash.dialog(
            controller: controller,
            alignment: const Alignment(0, 0.5),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            enableDrag: false,
            backgroundColor: Colors.black87,
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(message),
              ),
            ),
          );
        },
        duration: const Duration(seconds: 3),
      ).whenComplete(() {
        if (_messageQueue.isNotEmpty) {
          final item = _messageQueue.removeFirst();
          item.completer.complete(showToast(item.message));
        } else {
          _previousCompleter.complete();
        }
      });
    }

    return showToast(message);
  }

  static Color _backgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    return theme.dialogTheme?.backgroundColor ?? theme.dialogBackgroundColor;
  }

  static TextStyle _titleStyle(BuildContext context, [Color color]) {
    final theme = Theme.of(context);
    return (theme.dialogTheme?.titleTextStyle ?? theme.textTheme.headline6)
        .copyWith(color: color);
  }

  static TextStyle _contentStyle(BuildContext context, [Color color]) {
    final theme = Theme.of(context);
    return (theme.dialogTheme?.contentTextStyle ?? theme.textTheme.bodyText2)
        .copyWith(color: color);
  }

  static Future<T> infoBar<T>(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            message: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.info_outline, color: Colors.green[300]),
            leftBarIndicatorColor: Colors.green[300],
          ),
        );
      },
    );
  }

  static Future<T> successBar<T>(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            message: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.check_circle, color: Colors.blue[300]),
            leftBarIndicatorColor: Colors.blue[300],
          ),
        );
      },
    );
  }

  static Future<T> errorBar<T>(
    BuildContext context, {
    String title,
    @required String message,
    ChildBuilder<T> primaryAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (context == null) return Future.value();
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return StatefulBuilder(builder: (context, setState) {
          return Flash(
            controller: controller,
            horizontalDismissDirection: HorizontalDismissDirection.horizontal,
            backgroundColor: Colors.black87,
            child: FlashBar(
              title: title == null
                  ? null
                  : Text(title, style: _titleStyle(context, Colors.white)),
              message:
                  Text(message, style: _contentStyle(context, Colors.white)),
              primaryAction: primaryAction?.call(context, controller, setState),
              icon: Icon(Icons.warning, color: Colors.red[300]),
              leftBarIndicatorColor: Colors.red[300],
            ),
          );
        });
      },
    );
  }

  static Future<T> actionBar<T>(
    BuildContext context, {
    String title,
    @required String message,
    @required ChildBuilder<T> primaryAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    return showFlash<T>(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return StatefulBuilder(builder: (context, setState) {
          return Flash(
            controller: controller,
            horizontalDismissDirection: HorizontalDismissDirection.horizontal,
            backgroundColor: Colors.black87,
            child: FlashBar(
              title: title == null
                  ? null
                  : Text(title, style: _titleStyle(context, Colors.white)),
              message:
                  Text(message, style: _contentStyle(context, Colors.white)),
              primaryAction: primaryAction?.call(context, controller, setState),
            ),
          );
        });
      },
    );
  }

  static Future<T> simpleDialog<T>(
    BuildContext context, {
    String title,
    @required String message,
    Color messageColor,
    ChildBuilder<T> negativeAction,
    ChildBuilder<T> positiveAction,
  }) {
    return showFlash<T>(
      context: context,
      builder: (context, controller) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Flash.dialog(
              controller: controller,
              backgroundColor: _backgroundColor(context),
              margin: const EdgeInsets.only(left: 40.0, right: 40.0),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: FlashBar(
                title: title == null
                    ? null
                    : Text(title, style: _titleStyle(context)),
                message:
                    Text(message, style: _contentStyle(context, messageColor)),
                actions: <Widget>[
                  if (negativeAction != null)
                    negativeAction(context, controller, setState),
                  if (positiveAction != null)
                    positiveAction(context, controller, setState),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Future<T> customDialog<T>(
    BuildContext context, {
    ChildBuilder<T> titleBuilder,
    @required ChildBuilder messageBuilder,
    ChildBuilder<T> negativeAction,
    ChildBuilder<T> positiveAction,
  }) {
    return showFlash<T>(
      context: context,
      persistent: false,
      builder: (context, controller) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Flash.dialog(
              controller: controller,
              backgroundColor: _backgroundColor(context),
              margin: const EdgeInsets.only(left: 40.0, right: 40.0),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: FlashBar(
                title: DefaultTextStyle(
                  style: _titleStyle(context),
                  child: titleBuilder?.call(context, controller, setState),
                ),
                message: DefaultTextStyle(
                  style: _contentStyle(context),
                  child: messageBuilder.call(context, controller, setState),
                ),
                actions: <Widget>[
                  if (negativeAction != null)
                    negativeAction(context, controller, setState),
                  if (positiveAction != null)
                    positiveAction(context, controller, setState),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Future<T> blockDialog<T>(
    BuildContext context, {
    @required Completer<T> dismissCompleter,
  }) {
    final controller = FlashController<T>(
      context,
      (context, FlashController<T> controller) {
        return Flash.dialog(
          controller: controller,
          barrierDismissible: false,
          backgroundColor: Colors.black87,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        );
      },
    );
    dismissCompleter.future.then((value) => controller.dismiss(value));
    return controller.show();
  }

  static Future<T> blockErrorMessage<T>(
    BuildContext context, {
    String message,
    @required Completer<T> dismissCompleter,
  }) {
    final controller = FlashController<T>(
      context,
      (context, FlashController<T> controller) {
        return Flash.dialog(
          controller: controller,
          barrierDismissible: false,
          backgroundColor: Colors.black87,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
    dismissCompleter.future.then((value) => controller.dismiss(value));
    return controller.show();
  }

  static Future<T> blockSuccessMessage<T>(
    BuildContext context, {
    String message,
    @required Completer<T> dismissCompleter,
  }) {
    final controller = FlashController<T>(
      context,
      (context, FlashController<T> controller) {
        return Flash.dialog(
          controller: controller,
          barrierDismissible: false,
          backgroundColor: Colors.black87,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
    dismissCompleter.future.then((value) => controller.dismiss(value));
    return controller.show();
  }

  static Future<T> blockMessage<T>(
    BuildContext context, {
    String message,
    @required Completer<T> dismissCompleter,
  }) {
    final controller = FlashController<T>(
      context,
      (context, FlashController<T> controller) {
        return Flash.dialog(
          controller: controller,
          barrierDismissible: false,
          backgroundColor: Colors.black87,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
          ),
        );
      },
    );
    dismissCompleter.future.then((value) => controller.dismiss(value));
    return controller.show();
  }

  static Future<String> inputDialog(
    BuildContext context, {
    String title,
    String message,
    String defaultValue,
    bool persistent = true,
    WillPopCallback onWillPop,
  }) {
    final editingController = TextEditingController(text: defaultValue);
    return showFlash<String>(
      context: context,
      persistent: persistent,
      onWillPop: onWillPop,
      builder: (context, controller) {
        final theme = Theme.of(context);
        return Flash<String>.bar(
          controller: controller,
          barrierColor: Colors.black54,
          borderWidth: 3,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: const TextStyle(fontSize: 24.0)),
            message: Column(
              children: [
                if (message != null) Text(message),
                Form(
                  child: TextFormField(
                    controller: editingController,
                    autofocus: true,
                  ),
                ),
              ],
            ),
            leftBarIndicatorColor: theme.primaryColor,
            primaryAction: IconButton(
              onPressed: () {
                final message = editingController.text;
                controller.dismiss(message);
              },
              icon: Icon(Icons.send, color: theme.colorScheme.secondary),
            ),
          ),
        );
      },
    );
  }
}

typedef ChildBuilder<T> = Widget Function(
    BuildContext context, FlashController<T> controller, StateSetter setState);
