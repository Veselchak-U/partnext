import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';

class AdaptiveForwardIcon extends StatelessWidget {
  final Color color;

  const AdaptiveForwardIcon({
    this.color = AppColors.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = switch (Theme.of(context).platform) {
      TargetPlatform.iOS => Icons.arrow_forward_ios_rounded,
      _ => Icons.arrow_forward_rounded,
    };

    return Icon(
      iconData,
      size: 24.r,
      color: color,
    );
  }
}
