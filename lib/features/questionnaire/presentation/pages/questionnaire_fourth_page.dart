import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/layouts/main_simple_layout.dart';
import 'package:partnext/common/widgets/choice_chips.dart';
import 'package:partnext/features/questionnaire/domain/model/interest_type.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:provider/provider.dart';

class QuestionnaireFourthPage extends StatefulWidget {
  const QuestionnaireFourthPage({super.key});

  @override
  State<QuestionnaireFourthPage> createState() => _QuestionnaireFourthPageState();
}

class _QuestionnaireFourthPageState extends State<QuestionnaireFourthPage>
    with AutomaticKeepAliveClientMixin<QuestionnaireFourthPage> {
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
          Container(
            height: 64.h,
            alignment: Alignment.center,
            child: Text(
              context.l10n.partner_interests,
              style: AppTextStyles.s20w700,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8).r,
              child: ChoiceChips<InterestType>(
                items: InterestType.values,
                selectedItems: vm.questionnaire.partnerInterests,
                onTap: vm.onSelectPartnerInterest,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
