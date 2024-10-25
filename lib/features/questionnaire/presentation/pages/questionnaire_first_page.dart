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

class QuestionnaireFirstPage extends StatefulWidget {
  const QuestionnaireFirstPage({super.key});

  @override
  State<QuestionnaireFirstPage> createState() => _QuestionnaireFirstPageState();
}

class _QuestionnaireFirstPageState extends State<QuestionnaireFirstPage> {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<QuestionnaireScreenVm>();

    return MainSimpleLayout(
      body: Form(
        key: vm.firstFormKey,
        child: Column(
          children: [
            SizedBox(height: 9.h),
            Text(
              context.l10n.what_am_i,
              style: AppTextStyles.s20w700,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 44.h),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8).r,
                itemCount: PartnershipType.values.length,
                itemBuilder: (context, index) {
                  final item = PartnershipType.values[index];

                  return PartnershipTypeItem(
                    label: PartnershipTypeHelper.getIAmLookingForLabel(item),
                    selected: index.isEven,
                    onSelect: (value) {},
                  );
                },
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24).r,
              child: ValueListenableBuilder(
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
            ),
          ],
        ),
      ),
    );
  }
}
