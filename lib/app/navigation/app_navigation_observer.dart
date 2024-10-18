import 'package:flutter/material.dart';

typedef NavigatorListener = Function(
    Route<dynamic> route, Route<dynamic>? previousRoute);

class AppNavigationObserver extends NavigatorObserver {
  final List<NavigatorListener> _popListeners = [];

  void addPopListener(NavigatorListener listener) {
    _popListeners.add(listener);
  }

  void removePopListener(NavigatorListener listener) {
    _popListeners.remove(listener);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('!!! on didPop()');
    for (final listener in _popListeners) {
      listener.call(route, previousRoute);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('!!! on didPush()');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('!!! on didRemove()');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint('!!! on didReplace()');
  }
}
