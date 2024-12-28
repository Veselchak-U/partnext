import 'package:flutter/material.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/layouts/app_app_bar.dart';
import 'package:partnext/common/layouts/app_scaffold.dart';

class SimpleLayout extends StatelessWidget {
  final Widget body;
  final String? titleText;
  final VoidCallback? onBackButtonPressed;
  final List<Widget> actions;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const SimpleLayout({
    required this.body,
    this.titleText,
    this.onBackButtonPressed,
    this.actions = const [],
    this.backgroundColor = AppColors.background,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      safeAreaBottom: false,
      onTap: onTap,
      appBar: AppAppBar(
        titleText: titleText,
        leading: onBackButtonPressed != null ? BackButton(onPressed: onBackButtonPressed) : null,
        actions: actions,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
