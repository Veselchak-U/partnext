import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/navigation/app_route.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/features/welcome/presentation/widgets/welcome_body.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => setOpacity(1),
    );
  }

  void setOpacity(double value) {
    setState(() {
      _opacity = value;
    });
  }

  void _goSignUpScreen() {
    context.goNamed(AppRoute.signUp.name);
  }

  void _goLoginScreen() {
    context.goNamed(AppRoute.login.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const WelcomeBody(),
          SafeArea(
            child: SizedBox(
              height: max(145, 145.h),
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32).w,
                  child: Column(
                    children: [
                      const Spacer(),
                      CommonButton(
                        label: context.l10n.start,
                        onTap: _goSignUpScreen,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4).h,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.l10n.already_have_account,
                              style: AppTextStyles.s14w400,
                            ),
                            TextButton(
                              onPressed: _goLoginScreen,
                              child: Text(context.l10n.login),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
