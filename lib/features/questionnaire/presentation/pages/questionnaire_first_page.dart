import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/features/questionnaire/domain/model/partnership_type.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:partnext/features/questionnaire/presentation/widgets/partnership_type_item.dart';
import 'package:provider/provider.dart';

class QuestionnaireFirstPage extends StatefulWidget {
  const QuestionnaireFirstPage({super.key});

  @override
  State<QuestionnaireFirstPage> createState() => _QuestionnaireFirstPageState();
}

class _QuestionnaireFirstPageState extends State<QuestionnaireFirstPage>
    with AutomaticKeepAliveClientMixin<QuestionnaireFirstPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final vm = context.read<QuestionnaireScreenVm>();

    return Column(
      children: [
        Container(
          height: 64.h,
          alignment: Alignment.center,
          child: Text(
            context.l10n.what_am_i,
            style: AppTextStyles.s20w700,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8).r,
            itemCount: PartnershipType.values.length,
            itemBuilder: (context, index) {
              final item = PartnershipType.values[index];

              return PartnershipTypeItem(
                label: PartnershipTypeHelper.getWhoIAmLabel(item),
                selected: vm.questionnaire.myPartnershipTypes.contains(item),
                onSelect: (selected) => vm.onMyPartnershipTypeSelected(item, selected),
                onOpenDescription: (context) => vm.openOverlay(
                  context,
                  text: PartnershipTypeHelper.getWhoIAmDescription(item),
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
          ),
        ),
      ],
    );
  }
}
