import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/features/profile/presentation/upgrade/upgrade_screen_vm.dart';
import 'package:partnext/features/profile/presentation/upgrade/widget/upgrade_option.dart';
import 'package:provider/provider.dart';

class CurrentPlan extends StatelessWidget {
  const CurrentPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<UpgradeScreenVm>();
    final currentPlan = vm.currentPlan;

    if (currentPlan == null) {
      return Column(
        children: [
          UpgradeOption(
            svgAsset: Assets.icons.handshake40.path,
            text: context.l10n.who_wanted_create_business_with_you,
          ),
          SizedBox(height: 16.h),
          UpgradeOption(
            svgAsset: Assets.icons.chat40.path,
            text: context.l10n.start_conversation_with_partners,
          ),
          SizedBox(height: 16.h),
          UpgradeOption(
            svgAsset: Assets.icons.star40.path,
            text: context.l10n.unlimited_business_collaborations,
          ),
          SizedBox(height: 24.h),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(8).r,
          ),
          padding: EdgeInsets.fromLTRB(8, 16, 16, 8).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 8.r),
                      child: Text(
                        currentPlan.name,
                        style: AppTextStyles.s20w700.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${currentPlan.price}₪',
                        style: AppTextStyles.s20w400.copyWith(color: AppColors.white),
                      ),
                      Text(
                        context.l10n.per_month,
                        style: AppTextStyles.s16w400.copyWith(color: AppColors.white),
                      ),
                      Text(
                        context.l10n.total(currentPlan.priceTotal.toStringAsFixed(2)),
                        style: AppTextStyles.s20w400.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              TextButton(
                onPressed: vm.onCancelCurrentPlan,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8).w,
                  child: Text(
                    context.l10n.cancel_this_plan,
                    style: AppTextStyles.s16w700.copyWith(
                      color: AppColors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          context.l10n.our_plans,
          style: AppTextStyles.s20w700,
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
