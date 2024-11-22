import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/assets/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/layouts/main_simple_layout.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:provider/provider.dart';

class QuestionnaireSixthPage extends StatefulWidget {
  const QuestionnaireSixthPage({super.key});

  @override
  State<QuestionnaireSixthPage> createState() => _QuestionnaireSixthPageState();
}

class _QuestionnaireSixthPageState extends State<QuestionnaireSixthPage>
    with AutomaticKeepAliveClientMixin<QuestionnaireSixthPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final vm = context.read<QuestionnaireScreenVm>();

    return MainSimpleLayout(
      onTap: vm.closeOverlay,
      body: Column(
        children: [
          SizedBox(height: 9.h),
          Text(
            context.l10n.tell_us_about_yourself,
            style: AppTextStyles.s20w700,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 44.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8).r,
              child: Column(
                children: [],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16).r,
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: vm.loading,
                  builder: (context, loading, _) {
                    return CommonButton(
                      label: context.l10n.finish_registration,
                      iconPath: Assets.icons.send.path,
                      onTap: vm.onNextPage,
                      loading: loading,
                    );
                  },
                ),
                SizedBox(height: 16.h),
                CommonButton(
                  type: CommonButtonType.bordered,
                  label: context.l10n.previous,
                  iconPath: Assets.icons.send.path,
                  onTap: vm.onPreviousPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
