import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';

class PhotoItemView extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onDelete;

  const PhotoItemView({
    required this.imageUrl,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8).r;

    return SizedBox(
      width: 248.w,
      height: 284.h,
      child: Material(
        color: AppColors.white,
        borderRadius: borderRadius,
        child: imageUrl.isEmpty
            ? const SizedBox.shrink()
            : Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: IconButton(
                      icon: SvgPicture.asset(Assets.icons.closeFilled.path),
                      onPressed: onDelete,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
