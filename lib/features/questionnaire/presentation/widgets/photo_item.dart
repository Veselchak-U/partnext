import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';

class PhotoItem extends StatefulWidget {
  const PhotoItem({super.key});

  @override
  State<PhotoItem> createState() => _PhotoItemState();
}

class _PhotoItemState extends State<PhotoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 83.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8).r,
      ),
    );
  }
}
