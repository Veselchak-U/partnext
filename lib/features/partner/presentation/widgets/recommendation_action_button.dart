import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RecommendationActionButton extends StatelessWidget {
  final String asset;
  final VoidCallback onTap;

  const RecommendationActionButton({
    required this.asset,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final side = 72.h;
    final borderRadius = BorderRadius.circular(8).r;

    return SizedBox(
      width: side,
      height: side,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(asset),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
