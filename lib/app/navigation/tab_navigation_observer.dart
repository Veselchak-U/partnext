import 'package:flutter/material.dart';

class TabNavigationObserver extends NavigatorObserver {
  final String? debugLabel;

  TabNavigationObserver({
    this.debugLabel,
  });

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('!!! Tab $debugLabel on didPop()');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('!!! Tab $debugLabel on didPush()');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('!!! Tab $debugLabel on didRemove()');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint('!!! Tab $debugLabel on didReplace()');
  }
}
