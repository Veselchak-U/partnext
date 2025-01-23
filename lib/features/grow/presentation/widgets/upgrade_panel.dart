import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_shadows.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';

class UpgradePanel extends StatelessWidget {
  final double height;
  final VoidCallback onTap;

  const UpgradePanel({
    required this.height,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.backgroundBright,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(8).r,
        ),
        boxShadow: [AppShadows.container],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 56.w),
        child: Column(
          children: [
            Spacer(flex: 2),
            SizedBox(height: 9.h),
            Text(
              context.l10n.partnext_grow,
              style: AppTextStyles.s20w700,
            ),
            Text(
              context.l10n.your_growth_can_accelerate,
              style: AppTextStyles.s14w400,
              textAlign: TextAlign.center,
            ),
            Spacer(flex: 1),
            CommonButton(
              label: context.l10n.upgrade_to_premium,
              onTap: onTap,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
