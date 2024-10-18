import 'package:flutter/material.dart';
import 'package:partnext/app/service/logger/logger_service.dart';

class AppOverlays {
  static late GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;
  static late ThemeData _theme;

  static void init({
    required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    required ThemeData theme,
  }) {
    _scaffoldMessengerKey = scaffoldMessengerKey;
    _theme = theme;
  }

  static void showErrorSnack(
    String message, {
    Duration duration = const Duration(seconds: 5),
    SnackBarAction? action,
    isError = true,
  }) {
    LoggerService().d('AppOverlays.showErrorSnack(): $message');
    final scaffoldMessenger = _scaffoldMessengerKey.currentState;
    if (scaffoldMessenger == null) {
      return;
    }

    final backgroundColor = isError ? _theme.colorScheme.error : null;
    final textColor = isError ? _theme.colorScheme.onError : null;
    final snack = SnackBar(
      duration: duration,
      content: Text(
        message,
        key: ValueKey(DateTime.now().millisecondsSinceEpoch),
        style: TextStyle(color: textColor),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: backgroundColor,
      action: action,
    );

    Future.delayed(
      Duration.zero,
      () {
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger.showSnackBar(snack);
      },
    );
  }

  static void showErrorBanner(
    String message, {
    Duration duration = const Duration(seconds: 3),
    List<Widget> actions = const [SizedBox.shrink()],
    isError = true,
  }) {
    LoggerService().d('AppOverlays.showErrorBanner(): $message');
    final scaffoldMessenger = _scaffoldMessengerKey.currentState;
    if (scaffoldMessenger == null) {
      return;
    }

    final backgroundColor = isError ? _theme.colorScheme.error : null;
    final textColor = isError ? _theme.colorScheme.onError : null;
    final banner = MaterialBanner(
      backgroundColor: backgroundColor,
      elevation: 4,
      content: Text(
        message,
        style: TextStyle(color: textColor),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions,
    );

    Future.delayed(
      Duration.zero,
      () {
        bool visible = true;
        scaffoldMessenger.removeCurrentMaterialBanner();
        final controller = scaffoldMessenger.showMaterialBanner(banner);
        controller.closed.then((_) => visible = false);
        Future.delayed(
          duration,
          () {
            if (visible) controller.close();
          },
        );
      },
    );
  }
}
