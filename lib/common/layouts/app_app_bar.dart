import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/change_locale_button.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final TextStyle? titleTextStyle;
  final Widget? title;
  final double? titleSpacing;
  final bool automaticallyImplyLeading;
  final bool addChangeLocaleButton;
  final Widget? leading;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<Widget> actions;
  final ShapeBorder? shape;

  const AppAppBar({
    this.titleText,
    this.titleTextStyle,
    this.title,
    this.titleSpacing,
    this.automaticallyImplyLeading = true,
    this.addChangeLocaleButton = true,
    this.leading,
    this.backgroundColor = AppColors.white,
    this.foregroundColor = AppColors.primary,
    this.actions = const [],
    this.shape,
    super.key,
  }) : assert(titleText == null || title == null, 'Cannot provide both: "titleText" and "title"');

  @override
  Size get preferredSize => Size.fromHeight(max(kToolbarHeight, kToolbarHeight.h));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: shape,
      title: title ??
          Text(
            titleText ?? '',
            style: titleTextStyle ?? AppTextStyles.s18w500,
          ),
      titleSpacing: titleSpacing,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      actions: addChangeLocaleButton ? [const ChangeLocaleButton(), ...actions] : actions,
    );
  }
}
