import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';

class NoRecommendationsWidget extends StatelessWidget {
  final bool isTooManySwipes;
  final Future<void> Function() onRefresh;

  const NoRecommendationsWidget({
    required this.isTooManySwipes,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50).w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isTooManySwipes)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32).h,
                      child: SvgPicture.asset(
                        Assets.icons.swipe.path,
                        height: 77.h,
                      ),
                    ),
                  Text(
                    isTooManySwipes ? context.l10n.lot_of_swipes_today : context.l10n.no_recommendations_today,
                    style: AppTextStyles.s24w700,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    context.l10n.check_back_soon,
                    style: AppTextStyles.s14w400,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: constraints.maxHeight),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
