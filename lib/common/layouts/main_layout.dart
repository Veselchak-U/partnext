import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/layouts/app_app_bar.dart';
import 'package:partnext/common/layouts/focus_layout.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final String? titleText;
  final Widget? title;
  final List<Widget> actions;
  final VoidCallback? onBackButtonPressed;
  final bool extendBodyBehindAppBar;
  final Color backgroundColor;

  const MainLayout({
    required this.body,
    this.titleText,
    this.title,
    this.actions = const [],
    this.onBackButtonPressed,
    this.extendBodyBehindAppBar = true,
    this.backgroundColor = AppColors.background,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notchHeight = MediaQuery.of(context).padding.top;
    final toolbarHeight = max(kToolbarHeight, kToolbarHeight.h);
    final appBarRadius = const Radius.circular(16).r;
    final topBodyPadding = extendBodyBehindAppBar ? notchHeight + toolbarHeight - appBarRadius.y : 0.0;

    return FocusLayout(
      child: Scaffold(
        appBar: AppAppBar(
          titleText: titleText,
          title: titleText != null
              ? null
              : title ??
                  Image.asset(
                    Assets.images.appLogo.path,
                    height: 34.h,
                  ),
          leading: onBackButtonPressed != null ? BackButton(onPressed: onBackButtonPressed) : null,
          actions: actions,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: appBarRadius),
          ),
        ),
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        body: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(top: topBodyPadding),
            child: body,
          ),
        ),
      ),
    );
  }
}
