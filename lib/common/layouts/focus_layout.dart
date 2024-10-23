import 'package:flutter/material.dart';

class FocusLayout extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const FocusLayout({
    required this.child,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
