import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_colors.dart';
import 'package:partnext/common/layouts/gradient_layout.dart';
import 'package:partnext/common/widgets/loading_indicator.dart';
import 'package:partnext/features/questionnaire/presentation/pages/questionnaire_fifth_page.dart';
import 'package:partnext/features/questionnaire/presentation/pages/questionnaire_first_page.dart';
import 'package:partnext/features/questionnaire/presentation/pages/questionnaire_fourth_page.dart';
import 'package:partnext/features/questionnaire/presentation/pages/questionnaire_second_page.dart';
import 'package:partnext/features/questionnaire/presentation/pages/questionnaire_sixth_page.dart';
import 'package:partnext/features/questionnaire/presentation/pages/questionnaire_third_page.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:partnext/features/questionnaire/presentation/widgets/questionnaire_button_block.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<QuestionnaireScreenVm>();
    final titleHeight = 64.h;

    return GradientLayout(
      onTap: vm.closeOverlay,
      body: ValueListenableBuilder(
        valueListenable: vm.initializing,
        builder: (context, initializing, _) {
          if (initializing) return Center(child: const LoadingIndicator());

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: vm.pageController,
                      children: const [
                        QuestionnaireFirstPage(),
                        QuestionnaireSecondPage(),
                        QuestionnaireThirdPage(),
                        QuestionnaireFourthPage(),
                        QuestionnaireFifthPage(),
                        QuestionnaireSixthPage(),
                      ],
                    ),
                  ),
                  QuestionnaireButtonBlock(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: titleHeight),
                child: SmoothPageIndicator(
                  controller: vm.pageController,
                  textDirection: context.locale.isRtl ? TextDirection.rtl : TextDirection.ltr,
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
          );
        },
      ),
    );
  }
}
