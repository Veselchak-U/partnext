import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class UpgradeOption extends StatelessWidget {
  final String svgAsset;
  final String text;

  const UpgradeOption({
    required this.svgAsset,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            color: AppColors.backgroundBright,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.all(4).r,
          child: SvgPicture.asset(svgAsset),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.s14w400,
          ),
        ),
      ],
    );
  }
}
