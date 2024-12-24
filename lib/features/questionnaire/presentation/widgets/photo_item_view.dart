import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';

class PhotoItemView extends StatelessWidget {
  final String filePath;
  final VoidCallback onDelete;
  final String? imageUrl;

  const PhotoItemView({
    required this.filePath,
    required this.onDelete,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8).r;

    return Material(
      color: AppColors.white,
      borderRadius: borderRadius,
      child: SizedBox(
        width: 248.w,
        height: 284.h,
        child: filePath.isEmpty && imageUrl == null
            ? const SizedBox.shrink()
            : Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: borderRadius,
                    child: filePath.isEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl ?? '',
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(filePath),
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
