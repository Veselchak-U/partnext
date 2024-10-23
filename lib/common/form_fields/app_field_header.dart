import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class AppFieldHeader extends StatelessWidget {
  final String? text;
  final Color? color;

  const AppFieldHeader({
    required this.text,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if ((text ?? '').isEmpty) return const SizedBox.shrink();

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8).w,
      child: Text(
        text ?? '',
        style: AppTextStyles.s12w400.copyWith(color: color),
      ),
    );
  }
}
