import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/widgets/choice_chips.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/presentation/widgets/recommendation_action_button.dart';
import 'package:partnext/features/questionnaire/domain/model/partnership_type.dart';

class PartnerItemWidget extends StatelessWidget {
  final PartnerApiModel item;
  final VoidCallback onTap;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const PartnerItemWidget(
    this.item, {
    required this.onTap,
    required this.onApprove,
    required this.onReject,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8).r;

    return Material(
      color: AppColors.white,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: item.questionnaire.photos.first,
                    child: Container(
                      width: 112.r,
                      height: 112.r,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8).r,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            item.questionnaire.photos.first,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.h),
                        Text(
                          item.fullName,
                          style: AppTextStyles.s14w700,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          item.questionnaire.position ?? '',
                          style: AppTextStyles.s14w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ChoiceChips<PartnershipType>(
                items: item.questionnaire.myPartnershipTypes,
                borderColor: AppColors.primary,
              ),
              SizedBox(height: 16.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RecommendationActionButton(
                      asset: Assets.icons.reject.path,
                      onTap: onReject,
                    ),
                    RecommendationActionButton(
                      asset: Assets.icons.approve.path,
                      onTap: onApprove,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
