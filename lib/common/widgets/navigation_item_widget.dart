import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/widgets/adaptive_forward_icon.dart';

class NavigationItemWidget extends StatelessWidget {
  final String iconAsset;
  final String label;
  final VoidCallback? onTap;
  final bool? isDanger;

  const NavigationItemWidget({
    required this.iconAsset,
    required this.label,
    this.onTap,
    this.isDanger,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final foregroundColor = (isDanger == true ? AppColors.red : AppColors.primary).withValues(alpha: enabled ? 1 : 0.3);

    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
          child: Row(
            children: [
              SvgPicture.asset(
                iconAsset,
                height: 48.h,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.s14w700.copyWith(color: foregroundColor),
                ),
              ),
              SizedBox(width: 16.w),
              AdaptiveForwardIcon(color: foregroundColor),
            ],
          ),
        ),
      ),
    );
  }
}
