import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/features/profile/data/model/pricing_plan_api_model.dart';

class PlanCard extends StatelessWidget {
  final PricingPlanApiModel item;
  final double height;
  final Color borderColor;
  final ImageProvider backgroundImage;
  final VoidCallback onTap;

  const PlanCard({
    required this.item,
    required this.height,
    required this.borderColor,
    required this.backgroundImage,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.r);

    return Stack(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover,
            ),
            border: Border.all(color: borderColor),
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(16).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: AppTextStyles.s20w700,
                  ),
                  Row(
                    children: [
                      const SizedBox(height: 0),
                    ],
                  ),
                  Text(
                    '${item.price}₪',
                    style: AppTextStyles.s20w400,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (item.discount != null)
          PositionedDirectional(
            bottom: 12.r,
            end: 12.r,
            child: IgnorePointer(
              child: Container(
                width: 72.r,
                height: 72.r,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.save.toUpperCase(),
                      style: AppTextStyles.s16w700.copyWith(color: AppColors.green, height: 1),
                    ),
                    Text(
                      '${item.discount}%',
                      style: AppTextStyles.s23w700.copyWith(color: AppColors.green, height: 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
