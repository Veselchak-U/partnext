import 'package:flutter/material.dart';

class FocusLayout extends StatefulWidget {
  final Widget child;

  const FocusLayout({
    required this.child,
    super.key,
  });

  @override
  State<FocusLayout> createState() => _FocusLayoutState();
}

class _FocusLayoutState extends State<FocusLayout> {
  final _isTapDown = ValueNotifier<bool>(false);

  void _onTapDown() {
    FocusScope.of(context).unfocus();
    _isTapDown.value = true;
  }

  void _onTapUp() {
    _isTapDown.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _onTapDown(),
      onTapUp: (_) => _onTapUp(),
      child: ValueListenableBuilder(
        valueListenable: _isTapDown,
        builder: (context, isTapDown, child) {
          return FocusLayoutData(
            isTapDown: isTapDown,
            child: child ?? const SizedBox.shrink(),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class FocusLayoutData extends InheritedWidget {
  final bool? isTapDown;

  const FocusLayoutData({
    required super.child,
    this.isTapDown,
    super.key,
  });

  static FocusLayoutData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FocusLayoutData>();
  }

  @override
  bool updateShouldNotify(FocusLayoutData oldWidget) {
    return oldWidget.isTapDown != isTapDown;
  }
}
