import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/layouts/app_app_bar.dart';
import 'package:partnext/common/layouts/focus_layout.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final VoidCallback? onBackButtonPressed;
  final bool extendBodyBehindAppBar;
  final Color backgroundColor;

  const MainLayout({
    required this.body,
    this.onBackButtonPressed,
    this.extendBodyBehindAppBar = false,
    this.backgroundColor = AppColors.background,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appBarBorderRadius = const Radius.circular(16).r;
    final toolbarHeight = max(kToolbarHeight, kToolbarHeight.h);
    final topBodyPadding = extendBodyBehindAppBar ? toolbarHeight - appBarBorderRadius.y : 0.0;

    return FocusLayout(
      child: Scaffold(
        appBar: AppAppBar(
          title: Image.asset(
            Assets.images.appLogo.path,
            height: 34.h,
          ),
          leading: onBackButtonPressed != null ? BackButton(onPressed: onBackButtonPressed) : null,
          actions: [],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: appBarBorderRadius),
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
