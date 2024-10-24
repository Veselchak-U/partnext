import 'package:flutter/widgets.dart';

class AppTransitions {
  static Widget errorFieldTransitionBuilder(Widget child, Animation<double> animation) {
    return SlideTransition(
      key: ValueKey<Key?>(child.key),
      position: Tween<Offset>(
        begin: const Offset(0, -0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.decelerate,
        ),
      ),
      child: FadeTransition(
        key: ValueKey<Key?>(child.key),
        opacity: animation,
        child: child,
      ),
    );
  }
}
