import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double? value;
  final Color? color;
  final double? size;
  final double? strokeWidth;

  const LoadingIndicator({
    this.value,
    this.color,
    this.size,
    this.strokeWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final actualSize = size ?? 32.r;

    return RepaintBoundary(
      child: SizedBox(
        width: actualSize,
        height: actualSize,
        child: CircularProgressIndicator(
          value: value,
          color: color ?? AppColors.primary,
          strokeWidth: strokeWidth ?? 2,
        ),
      ),
    );
  }
}
