import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class StartChatMiniPhoto extends StatelessWidget {
  final String imageUrl;
  final String fullName;
  final String position;

  const StartChatMiniPhoto({
    required this.imageUrl,
    required this.fullName,
    required this.position,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: imageUrl,
          child: Container(
            width: 112.r,
            height: 112.r,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8).r,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Text(
                fullName,
                style: AppTextStyles.s14w700,
              ),
              SizedBox(height: 4.h),
              Text(
                position,
                style: AppTextStyles.s14w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
