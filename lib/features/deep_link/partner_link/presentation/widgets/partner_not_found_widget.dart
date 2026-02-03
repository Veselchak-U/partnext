import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';

class PartnerNotFoundWidget extends StatelessWidget {
  final VoidCallback onTap;

  const PartnerNotFoundWidget({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32).w,
      child: Column(
        children: [
          const Spacer(),
          Assets.images.logo.image(width: 174.w),
          SizedBox(height: 39.h),
          Text(
            context.l10n.partner_not_found,
            style: AppTextStyles.s24w700,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            context.l10n.partner_not_found_description,
            style: AppTextStyles.s14w400,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          CommonButton(
            label: context.l10n.continue_browsing,
            iconPath: Assets.icons.send.path,
            onTap: onTap,
          ),
          SizedBox(height: 48.h),
        ],
      ),
    );
  }
}
