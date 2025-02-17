import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class MessageMenuItem extends StatelessWidget {
  final String label;
  final String iconAsset;
  final VoidCallback onTap;
  final Color color;
  final BorderRadius? borderRadius;

  const MessageMenuItem({
    required this.label,
    required this.iconAsset,
    required this.onTap,
    this.color = AppColors.greenDark,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconAsset,
              height: 24.h,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: AppTextStyles.s14w600.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
