import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/assets/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/layouts/main_simple_layout.dart';
import 'package:partnext/features/questionnaire/domain/model/partnership_type.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:partnext/features/questionnaire/presentation/widgets/partnership_type_item.dart';
import 'package:provider/provider.dart';

class QuestionnaireSecondPage extends StatefulWidget {
  const QuestionnaireSecondPage({super.key});

  @override
  State<QuestionnaireSecondPage> createState() => _QuestionnaireSecondPageState();
}

class _QuestionnaireSecondPageState extends State<QuestionnaireSecondPage>
    with AutomaticKeepAliveClientMixin<QuestionnaireSecondPage> {
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
            context.l10n.i_am_looking_for,
            style: AppTextStyles.s20w700,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 44.h),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8).r,
              itemCount: PartnershipType.values.length,
              itemBuilder: (context, index) {
                final item = PartnershipType.values[index];

                return PartnershipTypeItem(
                  label: PartnershipTypeHelper.getIAmLookingForLabel(item),
                  selected: index.isEven,
                  onSelect: (selected) => vm.onPartnerPartnershipTypeSelected(item, selected),
                  onOpenDescription: (context) => vm.openOverlay(
                    context,
                    text: PartnershipTypeHelper.getIAmLookingForDescription(item),
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
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
                      label: context.l10n.next,
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
