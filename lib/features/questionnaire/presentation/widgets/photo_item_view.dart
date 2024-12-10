import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/assets/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';

class PhotoItemView extends StatelessWidget {
  final String filePath;
  final VoidCallback onDelete;

  const PhotoItemView({
    required this.filePath,
    required this.onDelete,
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
        child: filePath.isEmpty
            ? const SizedBox.shrink()
            : Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: borderRadius,
                    child: Image.file(
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
                  )
                ],
              ),
      ),
    );
  }
}
