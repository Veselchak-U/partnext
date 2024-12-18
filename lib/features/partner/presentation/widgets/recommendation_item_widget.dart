import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/app/style/app_shadows.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/widgets/choice_chips.dart';
import 'package:partnext/features/home/presentation/home_screen_vm.dart';
import 'package:partnext/features/partner/data/model/partner_api_model.dart';
import 'package:partnext/features/partner/presentation/widgets/recommendation_action_button.dart';
import 'package:partnext/features/partner/presentation/widgets/recommendation_photos_widget.dart';
import 'package:partnext/features/partner/presentation/widgets/recommendation_profile_url_widget.dart';
import 'package:partnext/features/questionnaire/domain/model/interest_type.dart';
import 'package:provider/provider.dart';

class RecommendationItemWidget extends StatelessWidget {
  final PartnerApiModel item;

  const RecommendationItemWidget(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [AppShadows.questionnaireItem],
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecommendationPhotosWidget(item.questionnaire.photos),
            SizedBox(height: 22.h),
            RecommendationProfileUrlWidget(
              item.questionnaire.profileUrl,
              onTap: () => vm.openLink(item.questionnaire.profileUrl),
            ),
            SizedBox(height: 25.h),
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
            Text(
              context.l10n.about_yourself,
              style: AppTextStyles.s20w700,
            ),
            SizedBox(height: 8.h),
            Text(
              item.questionnaire.bio ?? '',
              style: AppTextStyles.s14w400,
            ),
            SizedBox(height: 23.h),
            Text(
              context.l10n.what_partnership_are_you_looking,
              style: AppTextStyles.s20w700,
            ),
            SizedBox(height: 8.h),
            Text(
              item.questionnaire.partnershipDescription ?? '',
              style: AppTextStyles.s14w400,
            ),
            SizedBox(height: 25.h),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RecommendationActionButton(
                    asset: Assets.icons.reject.path,
                    onTap: vm.onReject,
                  ),
                  RecommendationActionButton(
                    asset: Assets.icons.approve.path,
                    onTap: vm.onApprove,
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
