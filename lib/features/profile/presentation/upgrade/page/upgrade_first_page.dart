import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/layouts/simple_layout.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:provider/provider.dart';

class UpgradeFirstPage extends StatelessWidget {
  const UpgradeFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UpgradeScreenVm>();

    return SimpleLayout(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 9.h),
              Text(
                'Partnext Premium', //context.l10n.send_feedback,
                style: AppTextStyles.s20w700,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
