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
  final _isTapped = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isTapped.dispose();
    super.dispose();
  }

  void _onTap() {
    FocusScope.of(context).unfocus();
    _isTapped.value = !_isTapped.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ValueListenableBuilder(
        valueListenable: _isTapped,
        builder: (context, isTapped, child) {
          return FocusLayoutData(
            isTapped: isTapped,
            child: child ?? const SizedBox.shrink(),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class FocusLayoutData extends InheritedWidget {
  final bool isTapped;

  const FocusLayoutData({
    required super.child,
    required this.isTapped,
    super.key,
  });

  static FocusLayoutData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FocusLayoutData>();
  }

  @override
  bool updateShouldNotify(FocusLayoutData oldWidget) {
    return oldWidget.isTapped != isTapped;
  }
}
