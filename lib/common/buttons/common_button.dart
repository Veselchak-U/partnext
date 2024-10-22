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

    return _isDisabled
        ? baseDecoration.copyWith(
            color: AppColors.gray,
          )
        : switch (type) {
            CommonButtonType.primary => baseDecoration.copyWith(
                color: AppColors.primary,
              ),
            CommonButtonType.bordered => baseDecoration.copyWith(
                border: Border.all(color: AppColors.primary),
              ),
          };
  }

  Color get foregroundColor {
    return _isDisabled
        ? AppColors.gray
        : switch (type) {
            CommonButtonType.primary => AppColors.white,
            CommonButtonType.bordered => AppColors.primary,
          };
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
                  iconPath != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16).r,
                          child: SvgPicture.asset(
                            iconPath ?? '',
                            width: 24.r,
                            height: 24.r,
                            colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
                          ),
                        )
                      : SizedBox(width: 16.r),
                  Text(
                    label,
                    style: textStyle ?? AppTextStyles.s16w700.copyWith(color: foregroundColor),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 16.r),
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
