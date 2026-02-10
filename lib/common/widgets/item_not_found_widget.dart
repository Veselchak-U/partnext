import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';

class ItemNotFoundWidget extends StatelessWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback onTap;

  const ItemNotFoundWidget({
    required this.title,
    required this.description,
    required this.buttonLabel,
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
            title,
            style: AppTextStyles.s24w700,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            description,
            style: AppTextStyles.s14w400,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          CommonButton(
            label: buttonLabel,
            iconPath: Assets.icons.send.path,
            onTap: onTap,
          ),
          SizedBox(height: 48.h),
        ],
      ),
    );
  }
}
