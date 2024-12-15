import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/change_locale_button.dart';
import 'package:partnext/common/buttons/common_button.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  void _goHomeScreen(BuildContext context) {
    context.goNamed(AppRoute.home.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Assets.images.mainGradient.image(
            width: 390.w,
            fit: BoxFit.fitWidth,
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Assets.images.successRegistration.image(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32).w,
                  child: Column(
                    children: [
                      Text(
                        context.l10n.registration_complete,
                        style: AppTextStyles.s36w800.copyWith(color: AppColors.primaryLight),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        context.l10n.registration_complete_description,
                        style: AppTextStyles.s14w400,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.h),
                      CommonButton(
                        label: context.l10n.start_browsing,
                        iconPath: Assets.icons.send.path,
                        onTap: () => _goHomeScreen(context),
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top,
            right: 0,
            child: ChangeLocaleButton(),
          ),
        ],
      ),
    );
  }
}
