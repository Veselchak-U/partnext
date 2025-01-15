import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/layouts/simple_layout.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:partnext/features/profile/presentation/upgrade/widget/current_plan.dart';
import 'package:partnext/features/profile/presentation/upgrade/widget/plan_grid.dart';
import 'package:provider/provider.dart';

class UpgradeFirstPage extends StatelessWidget {
  const UpgradeFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UpgradeScreenVm>();

    return SimpleLayout(
      backgroundColor: AppColors.white,
      onBackButtonPressed: vm.onBackButtonPressed,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32).w,
          child: Column(
            children: [
              SizedBox(height: 9.h),
              Text(
                'Partnext Premium',
                style: AppTextStyles.s20w700,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28.h),
              const CurrentPlan(),
              const PlanGrid(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24).h,
                child: ValueListenableBuilder(
                  valueListenable: vm.loading,
                  builder: (context, loading, _) {
                    return CommonButton(
                      label: context.l10n.continue_label,
                      iconPath: Assets.icons.send.path,
                      onTap: vm.onContinue,
                      loading: loading,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
