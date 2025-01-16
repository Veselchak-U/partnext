import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/layouts/simple_layout.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:partnext/features/profile/presentation/upgrade/widget/plan_label.dart';
import 'package:provider/provider.dart';

class UpgradeSecondPage extends StatelessWidget {
  const UpgradeSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UpgradeScreenVm>();

    return SimpleLayout(
      backgroundColor: AppColors.white,
      onBackButtonPressed: vm.onBackButtonPressed,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32).w,
        child: Column(
          children: [
            SizedBox(height: 9.h),
            Text(
              context.l10n.payment,
              style: AppTextStyles.s20w700,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),
            PlanLabel(vm.selectedPlan.value),
            SizedBox(height: 24.h),
            Text(
              context.l10n.payment_desc,
              style: AppTextStyles.s14w400,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24).h,
              child: ValueListenableBuilder(
                valueListenable: vm.loading,
                builder: (context, loading, _) {
                  return CommonButton(
                    label: context.l10n.confirm_purchase,
                    iconPath: Assets.icons.send.path,
                    onTap: vm.onConfirmPurchase,
                    loading: loading,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
