import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/change_locale_button.dart';
import 'package:partnext/config.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isProdBuild = Config.isProdBuild;

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
              SizedBox(height: max(145, 145.h)),
            ],
          ),
        ),
        if (!isProdBuild)
          Positioned(
            top: MediaQuery.of(context).viewPadding.top,
            right: 0,
            child: ChangeLocaleButton(),
          ),
      ],
    );
  }
}
