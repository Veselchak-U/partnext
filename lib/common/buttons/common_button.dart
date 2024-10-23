import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/widgets/loading_indicator.dart';

enum CommonButtonType { primary, bordered }

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final String? iconPath;
  final bool loading;
  final CommonButtonType type;

  const CommonButton({
    required this.label,
    required this.onTap,
    this.textStyle,
    this.iconPath,
    this.loading = false,
    this.type = CommonButtonType.primary,
    super.key,
  });

  bool get _isDisabled => onTap == null || loading;

  BorderRadius get _borderRadius => BorderRadius.circular(58).r;

  Decoration get _decoration {
    final baseDecoration = BoxDecoration(
      borderRadius: _borderRadius,
    );

    final backgroundColor = _isDisabled ? AppColors.disabled : AppColors.primary;

    return switch (type) {
      CommonButtonType.primary => baseDecoration.copyWith(
          color: backgroundColor,
        ),
      CommonButtonType.bordered => baseDecoration.copyWith(
          border: Border.all(color: backgroundColor, width: 2),
        ),
    };
  }

  Color get foregroundColor {
    return switch (type) {
      CommonButtonType.primary => AppColors.white,
      CommonButtonType.bordered => _isDisabled ? AppColors.disabled : AppColors.primary,
    };
  }

  Color get iconColor {
    return _isDisabled ? AppColors.disabled : AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: max(56, 56.h),
          decoration: _decoration,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isDisabled ? null : onTap,
              borderRadius: _borderRadius,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 56.w),
                  Expanded(
                    child: Text(
                      label,
                      style: textStyle ?? AppTextStyles.s16w700.copyWith(color: foregroundColor),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  iconPath != null
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8).w,
                          width: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            iconPath ?? '',
                            width: 24.w,
                            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                          ),
                        )
                      : SizedBox(width: 56.w),
                ],
              ),
            ),
          ),
        ),
        loading ? const LoadingIndicator(color: AppColors.white) : const SizedBox.shrink(),
      ],
    );
  }
}
