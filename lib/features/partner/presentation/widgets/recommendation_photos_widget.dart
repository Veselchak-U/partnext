import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';

class RecommendationPhotosWidget extends StatelessWidget {
  final List<String> urls;

  const RecommendationPhotosWidget(
    this.urls, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8).r;

    return Material(
      color: AppColors.white,
      borderRadius: borderRadius,
      child: SizedBox(
        height: 330.h,
        child: urls.isEmpty
            ? const SizedBox.shrink()
            : ClipRRect(
                borderRadius: borderRadius,
                child: CachedNetworkImage(
                  imageUrl: urls.first,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
