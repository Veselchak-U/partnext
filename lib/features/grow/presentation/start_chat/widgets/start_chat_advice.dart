import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class StartChatAdvice extends StatelessWidget {
  final String text;

  const StartChatAdvice({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          Assets.icons.positiveMark.path,
          height: 42.h,
        ),
        SizedBox(height: 15.h),
        Text(
          text,
          style: AppTextStyles.s14w400,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
