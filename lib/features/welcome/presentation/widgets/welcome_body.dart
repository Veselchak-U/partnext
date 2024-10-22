import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/assets/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Assets.images.mainGradient.image(
          width: 390.w,
          fit: BoxFit.fitWidth,
        ),
        SafeArea(
          child: Column(
            children: [
              SizedBox(height: 41.h),
              Assets.images.appLogo.image(width: 312.w),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16).r,
                  child: Assets.images.welcome.image(),
                ),
              ),
              Text(
                context.l10n.welcome_label,
                style: AppTextStyles.s14w600,
              ),
              SizedBox(height: 145.h),
            ],
          ),
        ),
      ],
    );
  }
}
