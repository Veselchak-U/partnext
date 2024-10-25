import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/layouts/app_scaffold.dart';
import 'package:partnext/features/questionnaire/presentation/pages/questionnaire_first_page.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<QuestionnaireScreenVm>();

    return AppScaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            reverse: context.locale.isRtl,
            controller: vm.pageController,
            children: const [
              QuestionnaireFirstPage(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 117).h,
            child: SmoothPageIndicator(
              controller: vm.pageController,
              textDirection: TextDirection.ltr,
              count: 6,
              effect: SlideEffect(
                dotWidth: 50.w,
                dotHeight: 4.h,
                spacing: 5.w,
                activeDotColor: AppColors.primary,
                dotColor: AppColors.backgroundDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
