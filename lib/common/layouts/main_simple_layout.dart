import 'package:flutter/material.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/layouts/app_app_bar.dart';
import 'package:partnext/common/layouts/app_scaffold.dart';

class MainSimpleLayout extends StatelessWidget {
  final Widget body;
  final String? titleText;
  final VoidCallback? onBackButtonPressed;
  final Color backgroundColor;

  const MainSimpleLayout({
    required this.body,
    this.titleText,
    this.onBackButtonPressed,
    this.backgroundColor = AppColors.background,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        titleText: titleText,
        leading: onBackButtonPressed != null ? BackButton(onPressed: onBackButtonPressed) : null,
      ),
      body: body,
    );
  }
}
