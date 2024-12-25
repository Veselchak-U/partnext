import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/layouts/app_app_bar.dart';
import 'package:partnext/common/layouts/app_scaffold.dart';

class MainSimpleLayout extends StatelessWidget {
  final Widget body;
  final String? titleText;
  final VoidCallback? onBackButtonPressed;
  final List<Widget> actions;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final bool withGradient;

  const MainSimpleLayout({
    required this.body,
    this.titleText,
    this.onBackButtonPressed,
    this.actions = const [],
    this.backgroundColor = AppColors.background,
    this.onTap,
    this.withGradient = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      safeAreaBottom: false,
      onTap: onTap,
      appBar: AppAppBar(
        titleText: titleText,
        leading: onBackButtonPressed != null ? BackButton(onPressed: onBackButtonPressed) : null,
        actions: actions,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          if (withGradient)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Assets.images.mainGradient.image(
                width: 390.w,
                fit: BoxFit.fitWidth,
              ),
            ),
          SafeArea(
            child: body,
          ),
        ],
      ),
    );
  }
}
