import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class ChatsAdPlate extends StatelessWidget {
  const ChatsAdPlate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          Container(
            width: 48.h,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10).r,
            ),
            child: Transform.flip(
              flipX: context.locale.isRtl,
              child: SvgPicture.asset(
                Assets.icons.rocketNavBar.path,
                colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.chats_ad_title,
                  style: AppTextStyles.s12w600.copyWith(color: AppColors.white),
                ),
                SizedBox(height: 4.h),
                Text(
                  context.l10n.chats_ad_desc,
                  style: AppTextStyles.s12w400.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }
}
