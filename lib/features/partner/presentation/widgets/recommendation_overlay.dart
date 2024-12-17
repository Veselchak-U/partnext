import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';

class RecommendationOverlay extends StatelessWidget {
  final bool swipeToRight;

  const RecommendationOverlay(
    this.swipeToRight, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final side = 92.h;
    final asset = swipeToRight ? Assets.icons.approve92.path : Assets.icons.reject92.path;

    return Center(
      child: SizedBox(
        width: side,
        height: side,
        child: SvgPicture.asset(asset),
      ),
    );
  }
}
