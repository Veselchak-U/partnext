import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class RecommendationProfileUrlWidget extends StatelessWidget {
  final String? profileUrl;
  final VoidCallback onTap;

  const RecommendationProfileUrlWidget(
    this.profileUrl, {
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (profileUrl == null) return const SizedBox.shrink();

    final borderRadius = BorderRadius.circular(8).r;

    return Material(
      color: AppColors.primarySecond,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: SizedBox(
          height: 48.h,
          child: Row(
            children: [
              SizedBox(width: 24.w),
              SvgPicture.asset(
                Assets.icons.linkedin.path,
                width: 32.w,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  profileUrl ?? '',
                  style: AppTextStyles.s14w600.copyWith(
                    color: AppColors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ),
        ),
      ),
    );
  }
}
