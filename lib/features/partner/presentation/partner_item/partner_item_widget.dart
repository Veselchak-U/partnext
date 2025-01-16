import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/widgets/choice_chips.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/presentation/widgets/recommendation_action_button.dart';
import 'package:partnext/features/partner/presentation/widgets/recommendation_photos_widget.dart';
import 'package:partnext/features/questionnaire/domain/model/interest_type.dart';
import 'package:partnext/features/questionnaire/domain/model/partnership_type.dart';

class PartnerItemWidget extends StatelessWidget {
  final PartnerApiModel item;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const PartnerItemWidget(
    this.item, {
    required this.onApprove,
    required this.onReject,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecommendationPhotosWidget(item.questionnaire.photos),
            SizedBox(height: 22.h),
            Text(
              item.fullName,
              style: AppTextStyles.s30w700,
            ),
            SizedBox(height: 6.h),
            Text(
              item.questionnaire.position ?? '',
              style: AppTextStyles.s14w400,
            ),
            SizedBox(height: 18.h),
            ChoiceChips<InterestType>(
              items: item.questionnaire.myInterests,
            ),
            SizedBox(height: 23.h),
            ChoiceChips<PartnershipType>(
              items: item.questionnaire.partnerPartnershipTypes,
            ),
            SizedBox(height: 25.h),
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
    );
  }
}
