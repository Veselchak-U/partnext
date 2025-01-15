import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

class PlanLabel extends StatelessWidget {
  final PricingPlanApiModel? plan;

  const PlanLabel(
    this.plan, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (plan == null) return const SizedBox.shrink();

    final borderRadius = BorderRadius.circular(8.r);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: AppColors.background,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 24, 12).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan?.name ?? '',
              style: AppTextStyles.s16w700,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${plan?.price}₪',
                    style: AppTextStyles.s14w400,
                  ),
                ),
                Text(
                  context.l10n.total(plan?.priceTotal ?? 0),
                  style: AppTextStyles.s14w400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
