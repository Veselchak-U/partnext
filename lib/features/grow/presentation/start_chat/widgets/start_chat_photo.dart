import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';

class StartChatPhoto extends StatelessWidget {
  final String imageUrl;

  const StartChatPhoto({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUrl,
      child: Container(
        width: 190.w,
        height: 255.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10).r,
          border: Border.all(color: AppColors.white, width: 3),
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
