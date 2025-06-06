import 'package:flutter/material.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/layouts/focus_layout.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Color backgroundColor;
  final Color? sysAppBarBackgroundColor;
  final bool resizeToAvoidBottomInset;
  final VoidCallback? onTap;
  final bool safeAreaBottom;
  final bool extendBodyBehindAppBar;

  const AppScaffold({
    required this.body,
    this.appBar,
    this.drawer,
    this.bottomNavigationBar,
    this.backgroundColor = AppColors.background,
    this.sysAppBarBackgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.onTap,
    this.safeAreaBottom = true,
    this.extendBodyBehindAppBar = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FocusLayout(
      child: ColoredBox(
        color: sysAppBarBackgroundColor ?? backgroundColor,
        child: SafeArea(
          bottom: safeAreaBottom,
          child: Scaffold(
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            appBar: appBar,
            drawer: drawer,
            body: body,
            bottomNavigationBar: bottomNavigationBar,
          ),
        ),
      ),
    );
  }
}
