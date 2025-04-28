import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class ChatMenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final String? iconAsset;
  final Color color;
  final BorderRadius? borderRadius;

  const ChatMenuItem({
    required this.label,
    required this.onTap,
    this.iconAsset,
    this.color = AppColors.greenDark,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final asset = iconAsset;

    return InkWell(
      borderRadius: borderRadius,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16.w,
          children: [
            if (asset != null)
              SvgPicture.asset(
                asset,
                height: 24.h,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
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
