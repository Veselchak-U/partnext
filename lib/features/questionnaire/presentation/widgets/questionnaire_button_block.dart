import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:provider/provider.dart';

class QuestionnaireButtonBlock extends StatelessWidget {
  const QuestionnaireButtonBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<QuestionnaireScreenVm>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16).r,
          child: ValueListenableBuilder(
            valueListenable: vm.isLastPage,
            builder: (context, isLastPage, _) {
              return ValueListenableBuilder(
                valueListenable: vm.loading,
                builder: (context, loading, _) {
                  return Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 150),
                        child: isLastPage
                            ? CommonButton(
                                key: ValueKey(true),
                                label: vm.isEditMode ? context.l10n.save : context.l10n.finish_registration,
                                iconPath: Assets.icons.send.path,
                                onTap: vm.onNextPage,
                                loading: loading,
                              )
                            : CommonButton(
                                key: ValueKey(false),
                                label: context.l10n.next,
                                iconPath: Assets.icons.send.path,
                                onTap: vm.onNextPage,
                                loading: loading,
                              ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
