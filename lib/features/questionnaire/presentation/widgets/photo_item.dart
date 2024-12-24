import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';

class PhotoItem extends StatelessWidget {
  final String filePath;
  final VoidCallback onTap;
  final String? imageUrl;

  const PhotoItem({
    required this.filePath,
    required this.onTap,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8).r;

    return Material(
      color: AppColors.white,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: SizedBox(
          width: 64.w,
          height: 83.h,
          child: filePath.isEmpty
              ? imageUrl == null
                  ? Center(
                      child: SvgPicture.asset(
                        Assets.icons.add.path,
                        width: 24.w,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: borderRadius,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    )
              : ClipRRect(
                  borderRadius: borderRadius,
                  child: Image.file(
                    File(filePath),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
